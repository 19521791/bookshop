class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: decoded_user_id)
  end

  def authenticate_admin
    return render_error unless current_user&.admin?
  end

  def authenticate_customer
    return render_error unless current_user&.customer?
  end

  def authenticate_public
    ::Utils.logger_color("Headers: #{request.headers.to_h}")
    ::Utils.logger_color("Access Token: #{request.headers['HTTP_ACCESS_TOKEN']}")
    ::Utils.logger_color("Secret Token: #{::ENV.fetch("SECRET_KEY", nil)}")
    return render_error unless request.headers['HTTP_ACCESS_TOKEN'] == ::ENV.fetch("SECRET_KEY", nil)
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

  def render_error
    render json: { error: 'Access denied.' }, status: :forbidden
  end
end