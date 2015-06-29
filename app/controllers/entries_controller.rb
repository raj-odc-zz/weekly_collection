class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :load_entry_type, only: [:new, :show, :edit]

  respond_to :html

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

  def create
    @entry = Entry.new(entry_params)
    @entry.save
    respond_with(@entry)
  end

  def update
    @entry.update(entry_params)
    respond_with(@entry)
  end

  def destroy
    @entry.destroy
    respond_with(@entry)
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
