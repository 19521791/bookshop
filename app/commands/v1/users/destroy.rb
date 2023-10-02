class V1::Users::Destroy
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.find_by(id: user_id)
    if user.nil?
      errors.add(:user, 'not found')
    elsif current_user.id == user.id
      user.destroy
    else
      errors.add(:user, 'Access denied. You can only delete your own data.') 
    end
  end

  private
  
  def user_id
    params[:user_id]
  end
end
