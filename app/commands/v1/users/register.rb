class V1::Users::Register
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.new( user_params )
    if user.valid?
      user.save
      UserPresenter.new(user).json_response
    else
      user.errors.full_messages.each do |message|
        errors.add(:base, message) 
      end
    end 
  end

  private

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