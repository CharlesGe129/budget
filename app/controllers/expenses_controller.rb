class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.this_month.order(:created_at)
    @sum, @avg = sum_expenses(@expenses)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @categories = Category.select('id', 'name').map(&categories_format)
  end

  def categories_format
    lambda { |element| [element.name, element.id] }
  end

  # GET /expenses/1/edit
  def edit
    @categories = Category.select('id', 'name').map(&categories_format)
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def test
    @expenses = Expense.this_month
    @monthly = {}
    Expense.all.group_by{ |m| m.created_at.beginning_of_month }.each_pair do |month, expenses|
      @monthly[month] = sum_expenses(expenses)
    end
  end

  def sum_expenses expenses
    @sum_expense = 0
    expenses.each do |each|
      if each.type_id == 0
        @sum_expense += each.amount
      elsif each.type_id == 1
        @sum_expense -= each.amount
      end
    end
    @avg_expense = @sum_expense / Date.today.day
    return @sum_expense, @avg_expense.round(2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:name, :type_id, :amount, :comment, :category_id)
    end
end
