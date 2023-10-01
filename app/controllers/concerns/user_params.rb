module UserParams
  extend ActiveSupport::Concern

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :email,
      :password,
      :role,
      :mobile
    )
  end

  def auth_params
    params.permit(
      :email,
      :password
    )
  end
end