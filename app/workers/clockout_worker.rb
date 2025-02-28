# frozen_string_literal: true

class ClockoutWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default', retry: 1

  def perform(user_id)
    SleepTracking.transaction do
      sleep_tracking = SleepTracking.where(clock_out: nil, user_id: user_id).lock(true).first
      if sleep_tracking
        sleep_tracking.update!(
          clock_out: Time.current,
          duration: (Time.current - sleep_tracking.clock_in).to_i
        )
        Rails.logger.info "Clock-out successful for User #{user_id} | Duration: #{sleep_tracking.duration} seconds"
      else
        Rails.logger.warn "No active sleep tracking record found for User #{user_id}"
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Clock-out failed for User #{user_id}: #{e.message}"
  ensure
    # release database connection after job execution
    ActiveRecord::Base.connection_pool.release_connection
  end
end
