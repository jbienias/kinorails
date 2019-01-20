module MoviesHelper

    # sorting
    def sort_link(column, title = nil)
        title ||= column.titleize
        direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
        arrowfinal = arrow(column)
        link_to "#{title} #{arrowfinal}".html_safe, {column: column, direction: direction}
    end

    def arrow(column)
        if params[:column] != column
        " ".html_safe
        elsif params[:direction] == 'asc'
        "<span class='fa fa-caret-up'></span>".html_safe
        else params[:direction] == 'desc'
        "<span class='fa fa-caret-down'></span>".html_safe
        end
    end
end
