class JsonWebToken
  def self.encode(payload, expiration = 7.days.from_now, key = ::Rails.application.secrets.secret_key_base)
    payload[:exp] = ::Integer(expiration, 10)
    ::JWT.encode(payload, key)
  end

  def self.decode(token, key = ::Rails.application.secrets.secret_key_base)
    ::HashWithIndifferentAccess.new(::JWT.decode(token, key)[0])
  rescue ::StandardError
    nil
  end
end
