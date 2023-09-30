module CheckRole
  extend ActiveSupport::Concern

  included do
    before_action :check_role
  end

  private

  def check_role
    if user_params[:role] != 1
      render json: { error: 'Access denied. Customers cannot register as admin.' }, status: :forbidden
    end
  end
end