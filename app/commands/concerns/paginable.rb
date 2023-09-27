module Paginable
    extend ActiveSupport::Concern

    def page_params
        params[:page] || 1
    end

    def per_page
        params[:per_page]
    end

    def pagination(records)
        {
            page: records.current_page,
            size: records.limit_value,
            prev_page: records.prev_page,
            next_page: records.next_page,
            total_page: records.total_pages,
            total_count: records.total_count
        }
    end
end