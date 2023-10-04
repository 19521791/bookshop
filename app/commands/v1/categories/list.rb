class V1::Categories::List
  prepend SimpleCommand
  attr_reader :params
  include Paginable
  def initialize(params)
      @params = params
  end

  def call
    {
      records: categories.map { |category| CategoryPresenter.new(category).json_response },
      pagination: pagination(categories)
    }
  end

  private

  def categories
    @categories ||= Category.search_params(keyword)
                            .order_by_fields(order_params, order_by)
                            .page(page_params)
                            .per(per_page)

  def keyword
      params[:keyword]
  end

  def order_params
      params[:order].present? ? params[:order].split(',') : []
  end

  def order_by
      params[:order_by].to_s.downcase
  end
end