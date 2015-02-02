class DiagramsController < UserApplication
  before_action :set_menu_items
  before_action :set_filters

  def line
    @selected_menu_items.push('report-line')
  end

  def pie
    @selected_menu_items.push('report-pie')
  end

  def data
    render json: Operation.get_for_filters(params[:filters], @auth_user.user_id)
  end

  private
  def set_menu_items
    @selected_menu_items.push('reports')
  end

  def set_filters
    @filters = Categories.group(:name).where(:user_id => @auth_user.user_id)
  end
end
