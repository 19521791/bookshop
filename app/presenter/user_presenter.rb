class UserPresenter < BasePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def json_response
  {
    id: user.id,
    username: "#{user.first_name} #{user.last_name}",
    email: user.email,
    role: user.role,
    mobile: user.mobile
  }
  end
end