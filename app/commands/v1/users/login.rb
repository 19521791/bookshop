class V1::Users::Login
  prepend SimpleCommand
  attr_reader :params
  include GenerateToken

  def initialize(params)
    @params = params
  end

  def call
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      generate_token(user)
    else
      errors.add :authentication, 'invalid email or password'
    end
  end

end