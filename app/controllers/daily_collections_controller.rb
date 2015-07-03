class DailyCollectionsController < ApplicationController
  before_action :set_daily_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :pdf

  def index
    respond_with(@daily_collections) do |format|
      format.pdf do
        @daily_collections = DailyCollection.date_wise_report(params[:date])
        render  :pdf => "#{params[:date].to_s}_collection_details.pdf", :template => 'daily_collections/index.pdf.erb'
      end
      @daily_collections = DailyCollection.date_wise_report(params[:date]).page(params[:page]).per(10)
      format.html
    end
  end

  def new
    @users = User.all
    @daily_collections = DailyCollection.new
    respond_with(@daily_collections)
  end

  def create
    collected_date = params[:daily_collection][:collection_date]
    collected_user = params[:daily_collection][:user_id]
    parsed_date   = Date.strptime(collected_date,'%d-%m-%Y')
    check_collection_entry = BulkImport.where(collection_date: parsed_date)
    day_name = parsed_date.strftime("%A")
    @loans = Loan.send(day_name.downcase)
    if check_collection_entry.blank? && @loans.size > 0
    bulk_import =  BulkImport.new(status: true, user_id: collected_user, collection_date: collected_date)
    bulk_import.save
    daily_insert = []
    @loans.each do |loan|
      daily_insert << DailyCollection.new(:loan_id => loan.id,
                                          :amount => 0,
                                          :user_id => collected_user,
                                          :collection_date => parsed_date)
    end
    DailyCollection.import daily_insert
    end
    redirect_to daily_collections_date_path(parsed_date)
  end

  def update
    @daily_collection = @daily_collection.balance_correction(params[:daily_collection][:amount])
    puts "@daily_collection",@daily_collection.inspect,@daily_collection.loan.balance_amount
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
