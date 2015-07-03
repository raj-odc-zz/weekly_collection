class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  before_action :load_customers, only: [:new, :show, :edit]

  respond_to :html

  def index
      if params[:active]
        load_loans('inactive')
      else
        load_loans('active')
      end
    respond_with(@loans)
  end

  def show
    respond_with(@loan)
  end

  def new
    @loan = Loan.new
    @loan.order_no = Loan.last.nil? ? 1 : Loan.last.order_no.to_i + 1
    respond_with(@loan)
  end

  def edit
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.save
    redirect_to loans_path
  end

  def update
    @loan.update(loan_params)
    redirect_to loans_path
  end

  def destroy
    @loan.update_columns(:active_status => false)
    respond_with(@loan)
  end

  private

    def load_loans(active_status)
      if !params[:search_name].blank? && params[:loan] && !params[:loan][:search_day].blank?
        @loans = Loan.search_name_day(params[:search_name], params[:loan][:search_day]).page(params[:page]).send(active_status)
      elsif !params[:search_name].blank?
        @loans = Loan.search_name(params[:search_name]).page(params[:page]).send(active_status)
      elsif params[:loan] && !params[:loan][:search_day].blank?
        @loans = Loan.send(params[:loan][:search_day]).page(params[:page]).send(active_status)
      else
        @loans = Loan.all.page(params[:page]).send(active_status)
      end
    end

    def set_loan
      @loan = Loan.find(params[:id])
    end

    def load_customers
      @customers = Customer.all
    end



    def loan_params
      params.require(:loan).permit(:customer_id, :order_no, :loan_type, :vasool_day, :given_date, :loan_amount, :given_amount, :installment_amount, :installments, :paid_amount, :balance_amount, :active_status)
    end
end
