module CheckRole
  extend ActiveSupport::Concern

  def check_role_admin
    if user_params[:role] != 1
      render json: { error: 'Access denied. Customers cannot register as admin.' }, status: :forbidden
    end
  end

  def check_role_customer
    if user_params[:role] == 1
      render json: { error: 'Access denied. Customers cannot register as admin.' }, status: :forbidden
    end
  end
end