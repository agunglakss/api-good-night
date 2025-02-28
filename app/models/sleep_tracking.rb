# frozen_string_literal: true

class SleepTracking < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true

  sleep_trakings_filter = -> (followed_ids) {
    SleepTracking.includes(:user)
                  .where(user_id: followed_ids)
                  .where('clock_in >= ? AND clock_in <= ?', 1.week.ago.beginning_of_day, Time.current)
                  .where.not(clock_out: nil)
                  .order('duration DESC')
  }
end
