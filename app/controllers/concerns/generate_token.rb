module GenerateToken
  extend ActiveSupport::Concern

  def generate_token(user)
    access_token = Auth.issue(user_id: user.id, login_token: ENV["AUTH_SECRET"])
    @data = {
      access_token: access_token,
      token_type: "Bearer"
    }
  end
end