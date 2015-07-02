class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      init_vars(params)
      render 'dashboard'
    else
      render 'landing'
    end
  end

  def init_vars(params)
    init_types
    init_entries(params[:date]) if params
    init_new_entry
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
    @entries[:vasool]  = DailyCollection.total_amount(date)
    @entries[:adappu]  = Loan.total_paid(date)
    @entries[:incomes] = entries.incomes
    @entries[:expenses] = entries.expenses
    @entries[:total_incomes] = entries.incomes.total_amount
    @entries[:total_expenses] = entries.expenses.total_amount
    @entries[:balance] = (@entries[:total_incomes] + @entries[:vasool]) - @entries[:total_expenses]
  end

  def init_previous_day_entries()

  end

  def init_new_entry
    @entry = Entry.new
  end
end
