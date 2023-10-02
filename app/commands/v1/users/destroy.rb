class V1::Users::Destroy
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
      user = User.find_by(id: user_id)
      user ? user.destroy : errors.add(:user, 'not found')
  end

  private
  
  def user_id
    params[:user_id]
  end
end
