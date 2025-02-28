# frozen_string_literal: true

class Api::V1::SleepTrackingsController < ApplicationController
  include ApiResponse

  def clock_in
    ClockinWorker.perform_async(@current_user.id)
    return success({ :message => "clock-in queued" },  :accepted)
  end

end
