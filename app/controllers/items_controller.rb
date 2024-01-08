class ItemsController < ApplicationController
  def create
    @item = budget.items.new(item_params)

    if @item.save
      redirect_to edit_budget_path(budget), flash: { notice: "Item added successfully" }
    else
      redirect_to edit_budget_path(budget), flash: { notice: "There was an error adding items" }   
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:title, :amount)
  end

  def budget
    @budget ||= Budget.find(params[:budget_id])
  end
end
