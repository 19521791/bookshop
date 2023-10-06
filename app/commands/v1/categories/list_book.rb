class V1::Categories::ListBook
  prepend SimpleCommand
  attr_reader :params
  include Paginable

  def initialize(params)
    @params = params
  end

  def call
    category = Category.find_by(id: params[:id])
                        .books
                        .page(page_params)
                        .per(per_page)

    return errors.add(:category, 'not found') unless category
    
    category
  end
end