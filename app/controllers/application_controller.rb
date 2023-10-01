class ApplicationController < ActionController::Base

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_user_id)
  end

  def authenticate
    render json: { error: "unauthorized" }, status: 401 unless logged_in?
  end

  private

  def token
    authorization_header = request.headers["Authorization"]
    if authorization_header && authorization_header.start_with?("Bearer ")
      authorization_header.split("Bearer ")[1]
    end
  end

  def decode_token
    access_token = token
    if access_token
      Auth.decode(access_token)
    end
  end
  
  def decoded_user_id
    decoded_data = decode_token
    decoded_data["user_id"] if decoded_data
  end
end