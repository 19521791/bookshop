class V1::Categories::Detail
    prepend SimpleCommand
    attr_reader :params

    def initialize(params)
        @params = params
    end

    def call
        category = Category.find_by(id: category_id)
        return errors.add(:category, 'not found') unless category
        CategoryPresenter.new(category).json_response
    end

    private

    def category_id
        params[:id]
    end
end