class DashboardController < ApplicationController
  include ApplicationHelper

  respond_to :html, :json, :pdf
  def index
    if current_user
      init_vars(params)
      render 'dashboard'
    else
      render 'landing'
    end
  end

  def create
    parsed_date   = Date.strptime(params[:dashboard][:entry_date],'%d-%m-%Y')
    redirect_to dashboard_date_path(parsed_date)
  end

  def init_vars(params)
    init_types
    init_entries(params[:date]) if params
    init_new_entry
  end

  def report
    @loans = Loan.send(get_next_dayname)

    respond_to do |format|
      format.pdf do
        pdf = NextdayReport.new(@loans)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end

  end

  private

  def init_types
    types = EntryType.all
    @types = {}
    @types[:incomes] = types.incomes
    @types[:expenses] = types.expenses
  end

  def init_entries(date)
    entries = Entry.by_date(date)
    @entries = {}
    prev_day_transaction = Transaction.by_date(Date.parse(date) - 1).first
    @entries[:opening_balance] = prev_day_transaction.closing_balance
    @entries[:collection]  = DailyCollection.total_amount(date)
    @entries[:new_loan]  = Loan.total_paid(date)
    @entries[:incomes] = entries.incomes
    @entries[:expenses] = entries.expenses
    @entries[:total_incomes] = entries.incomes.total_amount
    @entries[:total_expenses] = entries.expenses.total_amount
    @entries[:closing_balance] = (@entries[:opening_balance] + @entries[:total_incomes] + @entries[:collection]) - (@entries[:new_loan] + @entries[:total_expenses])
    Transaction.create_update(date, @entries)
  end

  def init_previous_day_entries()

  end

  def init_new_entry
    @entry = Entry.new
  end
end
