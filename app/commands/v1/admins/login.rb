class V1::Admins::Login
  prepend SimpleCommand
  attr_reader :params
  include GenerateToken

  def initialize(params)
    @params = params
  end

  def call
    user = User.find_by(email: params[:email])

    return errors.add :authentication, 'invalid email or password' unless user && user.authenticate(params[:password])
    
    generate_token(user)
  end

end