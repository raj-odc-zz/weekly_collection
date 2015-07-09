class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:active]
      load_customers('inactive')
    else
      load_customers('active')
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
    redirect_to customers_path
  end

  def update
    @customer.update(customer_params)
    redirect_to customers_path
  end

  def destroy
    @customer.update(:active_status => false)
    redirect_to customers_path
  end

  private

    def load_customers(active_status)
      if !params[:search_name].blank? && !params[:search_location].blank?
        @customers = Customer.search_name_location(params[:search_name]).order("created_at DESC").send(active_status).page(params[:page])
      elsif !params[:search_name].blank?
        @customers = Customer.search_name(params[:search_name]).order("created_at DESC").send(active_status).page(params[:page])
      elsif params[:search_location]
        @customers = Customer.search_location(params[:search_location]).order("created_at DESC").send(active_status).page(params[:page])
      else
        @customers = Customer.all.order('created_at DESC').send(active_status).page(params[:page])
      end
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name, :location, :mobile_number, :phone_number, :email_id, :address)
    end
end
