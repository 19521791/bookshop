class V1::Admins::List
  prepend SimpleCommand
  include Paginable
  attr_reader :params

  def initialize(params)
    @params = params
  end
  
  def call               
    {
        records: users.map { |user| UserPresenter.new(user).json_response },
        pagination: pagination(users)
    }
  end

  private

    def users
        @users ||= User.search_params(keyword)
                        .filtered_role(role)
                        .order_by_fields(order_params, order_by)
                        .page(page_params)
                        .per(per_page)
    end

    def keyword
        params[:keyword]
    end

    def order_params
        params[:order].present? ? params[:order].split(',') : []
    end

    def order_by
        params[:order_by].to_s.downcase
    end

    def role
      'admin'
    end
end