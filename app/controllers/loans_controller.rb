class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  before_action :load_customers, only: [:new, :show, :edit]

  respond_to :html

  def index
    @loans = Loan.all.page(params[:page])
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
    respond_with(@loan)
  end

  def update
    @loan.update(loan_params)
    respond_with(@loan)
  end

  def destroy
    @loan.destroy
    respond_with(@loan)
  end

  private
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
