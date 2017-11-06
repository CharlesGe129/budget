class StatController < ApplicationController

  def index
    @expenses = Expense.this_month
    @monthly = {}
    Expense.all.group_by{ |m| m.created_at.beginning_of_month }.each_pair do |month, expenses|
      @monthly[month] = sum_expenses(expenses)
    end
  end

  def sum_expenses(expenses)
    @sum_expense = 0
    @sum_income = 0
    expenses.each do |each|
      if each.type_id == 0
        @sum_expense += each.amount
      elsif each.type_id == 1
        @sum_income += each.amount
      end
    end
    { :expense => @sum_expense, :income => @sum_income}
  end

  def month
    month = Time.local(params[:month][0..3], params[:month][4..6], 1).to_s[0..9]
    @categories = Category.all
    @expenses = Expense.where("expenses.created_at like '#{month[0..7]}%'").where('type_id = ?', 0)
                    .joins(:category).group(:category_id).sum(:amount)
    @months = []
    @expenses.each do |expense|
      @month = {}
      @month[:amount] = expense[1]
      @month[:category] = @categories.find(expense[0]).name
      @months.append @month
    end
  end
end
