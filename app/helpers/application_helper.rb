module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "MicroFinanciaciones CEU"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end

  def transbol(bol)
    if bol
      'Si'
    else
      'No'
    end
  end

  def dateAndTime(d)
    if d
      d.strftime("%d/%m/%Y %H:%M")
    end
  end

end
