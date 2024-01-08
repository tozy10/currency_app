class ItemsController < ApplicationController
  def create
    @item = budget.items.new(item_params)

    if @item.save
      redirect_to edit_budget_path(budget), flash: { notice: "Item added successfully" }
    else
      redirect_to edit_budget_path(budget), flash: { notice: "There was an error adding items" }   
    end
  end

  def destroy
    items= budget.items.find(params[:id])
    if items.destroy
      redirect_to request.referer, flash: { notice: "Item deleted successfully" }
    else
      redirect_to request.referer, flash: { notice: "There was an error deleting an item" }   
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
