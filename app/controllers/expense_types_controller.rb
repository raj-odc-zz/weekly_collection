class ExpenseTypesController < ApplicationController
  before_action :set_expense_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @expense_types = ExpenseType.all
    respond_with(@expense_types)
  end

  def show
    respond_with(@expense_type)
  end

  def new
    @expense_type = ExpenseType.new
    respond_with(@expense_type)
  end

  def edit
  end

  def create
    @expense_type = ExpenseType.new(expense_type_params)
    @expense_type.save
    respond_with(@expense_type)
  end

  def update
    @expense_type.update(expense_type_params)
    respond_with(@expense_type)
  end

  def destroy
    @expense_type.destroy
    respond_with(@expense_type)
  end

  private
    def set_expense_type
      @expense_type = ExpenseType.find(params[:id])
    end

    def expense_type_params
      params.require(:expense_type).permit(:name)
    end
end
