class V1::Customers::Create
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.new( user_params.merge(role: 'customer') )
    
    return errors.add(:base, user.errors.full_messages) unless user.valid?
    
    user.save
        
    UserPresenter.new(user).json_response
  end

  private

  def user_params
    {
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email],
      password: params[:password],
      mobile: params[:mobile]
    }
  end
end