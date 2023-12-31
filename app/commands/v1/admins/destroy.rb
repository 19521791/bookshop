class V1::Admins::Destroy
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    user = User.find_by(id: user_id)

    return errors.add(:user, 'not found') unless user

    return errors.add(:user, 'Access denied') unless can_delete_user?(user)

    user.destroy
  end

  private
  
  def user_id
    params[:id]
  end

  def can_delete_user?(user)
    if current_user.admin?
      return (current_user == user) || (!user.admin?)
    else
      return false
    end
  end
  
  
end
