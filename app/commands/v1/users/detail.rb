class V1::Users::Detail
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.find_by(id: user_id)

    return errors.add(:user, 'not found') if user.nil?

    UserPresenter.new(user).json_response
    
  end

  private

  def user_id
    params[:id]
  end
end