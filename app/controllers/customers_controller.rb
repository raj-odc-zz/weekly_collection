class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if !params[:search_name].blank? && !params[:search_location].blank?
      @customers = Customer.search_name_location(params[:search_name]).order("created_at DESC")
      elsif !params[:search_name].blank?
      @customers = Customer.search_by_name(params[:search_name]).order("created_at DESC")
    elsif params[:search_location]
      @customers = Customer.search_by_location(params[:search_location]).order("created_at DESC")
    else
      @customers = Customer.all.order('created_at DESC')
    end
    respond_with(@customers)
  end

  def show
    respond_with(@customer)
  end

  def new
    @customer = Customer.new
    respond_with(@customer)
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    respond_with(@customer)
  end

  def update
    @customer.update(customer_params)
    respond_with(@customer)
  end

  def destroy
    @customer.destroy
    respond_with(@customer)
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name, :location, :mobile_number, :phone_number, :email_id, :address)
    end
end
