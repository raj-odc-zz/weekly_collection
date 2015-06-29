class DailyCollectionsController < ApplicationController
  before_action :set_daily_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @daily_collections = DailyCollection.all
    respond_with(@daily_collections)
  end

  def new
    @users = User.all
    @daily_collections = DailyCollection.new
    respond_with(@daily_collections)
  end

  def create
    collected_date = params[:daily_collection][:collection_date]
    collected_user = params[:daily_collection][:user_id]
    @bulk_import =  BulkImport.new(status: true, user_id: collected_user, collection_date: collected_date)
    @bulk_import.save
    parsed_date = Date.strptime(collected_date,'%d-%m-%Y')
    day_name = parsed_date.strftime("%A")
    puts "++++++++++",parsed_date.inspect,day_name.inspect
    @loans = Loan.send(day_name.downcase)
    daily_insert = []
    @loans.each do |loan|
      daily_insert << DailyCollection.new(:loan_id => loan.id, :amount => 0, :user_id => collected_user)
    end
    DailyCollection.import daily_insert
    redirect_to daily_collections_path
  end

  def update
    @daily_collection.update(:amount => params[:daily_collection][:amount])
    @daily_collection.loan.update(:balance_amount => @daily_collection.loan.balance_amount.to_i-10)
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
