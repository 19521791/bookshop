class V1::Users::Detail
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.filtered_role(flag).find_by(id: user_id)

    return errors.add(:user, 'not found') if user.nil?

    UserPresenter.new(user).json_response
  end

  private

  def user_id
    params[:user_id]
  end

  def flag
    params[:flag]
  end
end