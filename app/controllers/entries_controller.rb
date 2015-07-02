class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :load_entry_type, only: [:new, :show, :edit]

  respond_to :html

  def create
    Entry.create(entry_params)
    parsed_date   = Date.strptime(params[:entry][:entry_date],'%d-%m-%Y')
    redirect_to dashboard_date_path(parsed_date)
  end

  def destroy
    entry_record = Entry.find_by(id: params[:id])
    entry_record.try(:destroy)
    redirect_to dashboard_date_path(entry_record.entry_date), status: 303
  end

  def index
    @entries = Entry.all
    respond_with(@entries)
  end

  def show
    respond_with(@entry)
  end

  def new
    @entry = Entry.new
    respond_with(@entry)
  end

  def edit
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

  def load_entry_type
    @entry_types = EntryType.all
    @users = User.all
  end

    def entry_params
      params.require(:entry).permit(:entry_type_id, :user_id, :amount, :entry_date)
    end
end
