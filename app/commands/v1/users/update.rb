class V1::Users::Update
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.find_by(id: user_id)
    if current_user.id == user.id
      if user.update(user_params)
        UserPresenter.new(user).json_response
      else
        errors.add(:user, 'not found')
      end
    else
      errors.add(:user, 'Access denied. You can only update your own data.') 
    end
  end

  private

  def user_id
    params[:user_id]
  end

  def user_params
    {
      firstname: params[:firstname], 
      lastname: params[:lastname], 
      name: "#{params[:firstname]} #{params[:lastname]}",
      email: params[:email],
      password: params[:password],
      role: params[:role],
      mobile: params[:mobile]
    }
  end
end