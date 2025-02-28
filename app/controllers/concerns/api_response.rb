# frozen_string_literal: true

module ApiResponse
  extend ActiveSupport::Concern

  def success(data = {}, status)
    render json: data, status: status, content_type: 'application/json'
  end

  def error(error, status)
    render json: { error: error }, 
                    status: status, 
                    content_type: "application/json"
  end
end