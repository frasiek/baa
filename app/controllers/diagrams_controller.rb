class DiagramsController < UserApplication
  before_action :set_menu_items

  def line
    @selected_menu_items.push('report-line')
  end

  def pie
    @selected_menu_items.push('report-pie')
  end

  private
  def set_menu_items
    @selected_menu_items.push('reports')
  end
end
