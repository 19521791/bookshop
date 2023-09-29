class V1::Users::List
  prepend SimpleCommand
  include Paginable
  attr_reader :params

  def initialize(params)
    @params = params
  end
  
  def call
      users = User.all
                  .page(page_params)
                  .per(per_page)
      {
          records: users.map { |user| UserPresenter.new(user).json_response },
          pagy: pagination(users)
      }
  end
end