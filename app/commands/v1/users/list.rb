class V1::Users::List
  prepend SimpleCommand
  include Paginable
  attr_reader :params

  def initialize(params)
    @params = params
  end
  
  def call
      users = User.order_by_fields(order_params, order_by)
                  .search_params(keyword)
                  .page(page_params)
                  .per(per_page)
                  .filtered_role(flag)
      {
          records: users.map { |user| UserPresenter.new(user).json_response },
          pagination: pagination(users)
      }
  end

  private

    def keyword
        params[:keyword]
    end

    def order_params
        params[:order].present? ? params[:order].split(',') : []
    end

    def order_by
        params[:order_by].to_s.downcase
    end

    def flag
        params[:flag]
    end
end