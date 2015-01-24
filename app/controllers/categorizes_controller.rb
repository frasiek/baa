class CategorizesController < ApplicationController

  # GET /categorizes
  # GET /categorizes.json
  def index
    @operations = Operation.all_my_distinct
  end

end
