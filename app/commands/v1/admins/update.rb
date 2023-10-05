class V1::Admins::Update
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.find_by(id: user_id)
    
    return errors.add(:user, 'not found') unless user
  
    return errors.add(:user, 'Access denied. You can only update your own data.') if current_user.id != user.id
  
    user.assign_attributes(user_params)
  
    if user.valid?
      user.save
      UserPresenter.new(user).json_response
    else
      errors.add(:user, user.errors.full_messages)
    end
  end
  

  private

  def user_id
    params[:id]
  end

  def user_params
    {
      firstname: params[:firstname], 
      lastname: params[:lastname], 
      name: "#{params[:firstname]} #{params[:lastname]}",
      email: params[:email],
      password: params[:password],
      mobile: params[:mobile]
    }
  end
end