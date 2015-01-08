class BankAccountsController < UserApplication
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]
  before_action :set_menu_items

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all_mine(@auth_user.user_id)
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
    redirect_to bank_accounts_url
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit
    if @bank_account.user_id != @auth_user.user_id
      raise OwnerMismatchException
    end
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)
    @bank_account.user_id = @auth_user.user_id
    respond_to do |format|
      if @bank_account.save
        flash[:success] = t('bank_account_created')
        format.html { redirect_to @bank_account }
        format.json { render :show, status: :created, location: @bank_account }
      else
        format.html { render :new }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    if @bank_account.user_id != @auth_user.user_id
      raise OwnerMismatchException
    end
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        flash[:success] = t('bank_account_updated')
        format.html { redirect_to @bank_account}
        format.json { render :show, status: :ok, location: @bank_account }
      else
        format.html { render :edit }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    if @bank_account.user_id != @auth_user.user_id
      raise OwnerMismatchException
    end
    @bank_account.destroy
    flash[:success] = t('bank_account_destroyed')
    respond_to do |format|
      format.html { redirect_to bank_accounts_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_account_params
      params.require(:bank_account).permit(:name)
    end

    def set_menu_items
      @selected_menu_items.push('data', 'bank_accounts')
    end
end
