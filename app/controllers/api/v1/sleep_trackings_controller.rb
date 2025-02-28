# frozen_string_literal: true

class Api::V1::SleepTrackingsController < ApplicationController
  include ApiResponse

  def clock_in
    ClockinWorker.perform_async(@current_user.id)
    return success({ :message => "clock-in queued" },  :accepted)
  end

  def clock_out
    ClockoutWorker.perform_async(@current_user.id)
    return success({ :message =>'Clock-out request received, processing in background' }, :accepted)
  end

  def following
    # cache the entire result for 1 minute
    cache_key = "#{@current_user.id}"

    data = Rails.cache.fetch(cache_key, expires_in: 1.minute) do
      # get friendship ids based on current_user id and store into followed_ids variable
      followed_ids = Friendship.where(follower_id: @current_user.id).pluck(:followed_id)
      # mapping the result
      map_sleeping_tracking(SleepTracking.includes(:user)
                                          .where(user_id: followed_ids)
                                          .where('clock_in >= ? AND clock_in <= ?', 1.week.ago.beginning_of_day, Time.current)
                                          .where.not(clock_out: nil)
                                          .order('duration DESC'))
    end

    success(data, :ok)
  end

  private
  def map_sleeping_tracking(sleep_trackings)
    response_data = sleep_trackings.map do |tracking|
     {
       user_id: tracking.user_id,
       name: tracking.user.name,
       clock_in: tracking.clock_in,
       clock_out: tracking.clock_out,
       duration: tracking.clock_out ? tracking.duration : nil,
     }
   end
 end
end
