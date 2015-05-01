class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])

    # For admin, show price history
    @prices = @item.item_prices

    # For everyone else, show similar products
    @similar_items = Item.for_category(@item.category)
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
