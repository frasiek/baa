require 'csv'
class TransactionsController < UserApplication
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :import]

  def import
    separator = (params['separator'] == 'tab') ? "\t" : params['separator']
    import = Importer.new(@auth_user.user_id, @transaction.bank_account_id, @transaction.file, separator, params['encoding'], params[:skip_rows], params[:col])
    if import.import
      flash[:success] = t('Import_sucessful')
      redirect_to transactions_path
    else
      flash[:error] = import.error
      redirect_to :back
    end
  end

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    redirect_to transactions_path
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  # POST /transactions/1/edit
  def edit
    @file = false
    if request.post?
      @file = read_file_entry
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = @auth_user.user_id
    @transaction.file = save_file
    respond_to do |format|
      if @transaction.save
        flash[:success] = t('Transaction was successfully created.')
        format.html { redirect_to @transaction }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    if @transaction.user_id != @auth_user.user_id
      raise OwnerMismatchException
    end
    respond_to do |format|
      if @transaction.update(transaction_params)
        flash[:success] = t('Transaction was successfully updated.')
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    if @transaction.user_id != @auth_user.user_id
      raise OwnerMismatchException
    end
    @transaction.destroy
    flash[:success] = t('Transaction was successfully destroyed.')
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
      if @transaction.user_id != @auth_user.user_id
        raise OwnerMismatchException
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:bank_account_id)
    end

    def save_file
      name =  params[:transaction][:file].original_filename
      directory = "uploaded/usr" + @auth_user.user_id.to_s + "/"+Time.now.getutc.to_s
      # create the file path
      path = File.join(directory, name)
      require 'fileutils'
      FileUtils::mkdir_p directory
      # write the file
      File.open(path, "wb") { |f| f.write(params[:transaction][:file].read) }
      return path
    end

    def read_file_entry
      separator = (params['separator'] == 'tab') ? "\t" : params['separator']
      data = []
      line_no = 0
      File.open(@transaction.file, "r").each_line do |line|
        line_no += 1
        data.push(line.encode('utf-8', params['encoding'], :invalid => :replace, :undef => :replace, :replace => '').split(separator))

        if(line_no >= 4)
          break
        end
      end
      return data
    end
end
