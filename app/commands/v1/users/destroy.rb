class V1::Users::Destroy
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
      user = User.find_by(id: user_id)
      if current_user.id == user.id 
        user.destroy 
      else
        errors.add(:user, 'Access denied')
      end
  end

  private
  
  def user_id
    params[:user_id]
  end
end
