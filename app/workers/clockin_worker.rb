# frozen_string_literal: true

class ClockinWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(user_id)
    SleepTracking.transaction do
      # using "for update" to avoiding race condition when the same user hit at the time
      existing_record = SleepTracking.where(clock_out: nil, user_id: user_id).lock(true).first

      # if exist then return log and rollback to avoiding sidekiq retry the job
      if existing_record
        Rails.logger.error("Clock-in failed for User #{user_id}: Must clock out first.")
        raise ActiveRecord::Rollback
      end

      # insert to database
      SleepTracking.create!(user_id: user_id, clock_in: Time.current)
    ensure
      # release database connection after job execution
      ActiveRecord::Base.connection_pool.release_connection
    end
  end
end
