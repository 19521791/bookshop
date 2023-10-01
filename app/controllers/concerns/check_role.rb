module CheckRole
  extend ActiveSupport::Concern

  def check_role_admin
    user = User.find_by(email: user_params[:email])
    if user
      user.role == "admin" ? (return) : (render_error)
    else
      user_params[:role] == 1 ? (return) : (render_error)
    end
  end

  def check_role_customer
    user_params[:role] == 1 ? (render_error) : (return)
  end

  private

  def render_error
    render json: { error: 'Access denied.' }, status: :forbidden
  end
end