class CategorizesController < UserApplication
  before_action :set_menu_items
  # GET /categorizes
  # GET /categorizes.json
  def index
    @operations = Operation.all_my_distinct(@auth_user.user_id)
  end

  def addCategorie
    begin
      @c = Categories.new
      @c.keyword = params[:key_word]
      @c.name = params[:name]
      @c.user_id = @auth_user.user_id
      @c.save
    rescue ActiveRecord::RecordNotUnique
      render json: {'success'=>'error','message'=>t('duplicate')}
      return
    end
    render json: {'success'=>'success'}
  end

  def delCategorie()
    Categories.where(:id => params[:id], :user_id => @auth_user.user_id).destroy_all
    redirect_to :back
  end

  private
  def set_menu_items
    @selected_menu_items.push('data', 'operation_categories')
  end


end
