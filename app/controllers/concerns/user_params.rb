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
end