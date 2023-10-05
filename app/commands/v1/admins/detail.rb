class V1::Admins::Detail
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.filtered_role(flag).find_by(id: user_id)
                

    return errors.add(:user, 'not found') unless user

    if current_user.admin?
      return UserPresenter.new(user).json_response
    end

    return UserPresenter.new(user).json_response if current_user.customer? && user_id.to_i == current_user.id

    return errors.add(:user, 'Access denied')

  end

  private

  def user_id
    params[:id]
  end

  def flag
    params[:role]
  end
end