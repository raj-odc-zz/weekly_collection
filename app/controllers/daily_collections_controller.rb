class DailyCollectionsController < ApplicationController
  before_action :set_daily_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @daily_collections = DailyCollection.all
    respond_with(@daily_collections)
  end

  def show
    respond_with(@daily_collection)
  end

  def new
    @users = User.all
    @bulk_import = BulkImport.new
    respond_with(@daily_collection)
  end

  def edit
  end

  def create
    @bulk_import = BulkImport.new(customer_params)
    @bulk_import.save
    day_name = Date.today.strftime("%A")
    @loans = Loan.send(day_name.downcase)
    daily_insert = []
    @loans.each do |loan|
      daily_insert << DailyCollection.new(:loan_id => loan.id, :amount => 0, :user_id => @bulk_import.user.id)
    end
    DailyCollection.import daily_insert
    @daily_collection = DailyCollection.new()
    @daily_collection.save
    respond_with(@daily_collection)
  end

  def update
    @daily_collection.update(daily_collection_params)
    respond_with(@daily_collection)
  end

  def destroy
    @daily_collection.destroy
    respond_with(@daily_collection)
  end

  private
    def set_daily_collection
      @daily_collection = DailyCollection.find(params[:id])
    end

    def daily_collection_params
      params.require(:daily_collection).permit(:loan_id, :amount, :user_id)
    end
end
