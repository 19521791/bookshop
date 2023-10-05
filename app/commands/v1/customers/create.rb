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
      firstname: params[:firstname], 
      lastname: params[:lastname], 
      name: "#{params[:firstname]} #{params[:lastname]}",
      email: params[:email],
      role: params[:role],
      password: params[:password],
      mobile: params[:mobile]
    }
  end
end