class ApplicationController < ActionController::API
  include ApiResponse
  before_action :authenticate_api_token!
  
  private

  def authenticate_api_token!
    api_token = request.headers['API-TOKEN']
    @current_user = User.find_by(api_token: api_token)

    # return unauthorized if api_key does'nt exist
    error('Unauthorized', :unauthorized) unless @current_user
  end
end
