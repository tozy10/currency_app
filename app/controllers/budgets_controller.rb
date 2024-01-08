class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @budgets = Budget.new
  end

  def create
    @budget = current_user.budgets.build(title: params[:title])
    if @budget.save
      redirect_to edit_budget_path(@budget), flash: { notice: "Budget created successfully" }
    else
      redirect_to new_budget_path, flash: { notice: "There was an error creating budget" }   
    end
  end

  def edit
    @budget = Budget.find(params[:id])
    @item = Item.new
    @items = @budget.items
    @balance = current_user.balance - @budget.items.pluck(:amount).sum
  end

  def update
    @budget = current_user.budgets.find(params[:id]) 
    if @budget.update(budget_params)
      redirect_to edit_budget_path(@budget), flash: { notice: "Budget updated successfully" }
    else
      redirect_to edit_budget_path(@budget), flash: { notice: "There was an error updating budget" }   
    end  
  end

  def show
    @budget = current_user.budgets.find(params[:id])
    @items = @budget.items
    @balance = current_user.balance - @budget.items.pluck(:amount).sum
  end

  def index
    @budgets = current_user.budgets
  end

  def destroy
    @budget = current_user.budgets.find(params[:id])
    if @budget.destroy
      redirect_to budgets_path, flash: { notice: "Budget deleted successfully" }
    else
      redirect_to budgets_path, flash: { notice: "There was an error deleting budget" }   
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:title)
  end

end
