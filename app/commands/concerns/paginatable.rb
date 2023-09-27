module Paginatable
    extend ActiveSupport::Concern

    def page_params
        params[:page] || 1
    end

    def per_page
        params[:per_page] || 10
    end
end