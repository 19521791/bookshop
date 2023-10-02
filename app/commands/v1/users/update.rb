class V1::Users::Update
  prepend SimpleCommand
  attr_reader :params, :decoded_user_id

  def initialize(params, decoded_user_id)
    @params = params
    @decoded_user_id = decoded_user_id
  end

  def call
    if user_id == decoded_user_id

      user = User.find_by(id: user_id)

      if user.update(user_params)

        UserPresenter.new(user).json_response

      else

        errors.add(:user, 'not found') if user.nil?

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
