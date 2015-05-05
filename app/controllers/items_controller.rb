class ItemsController < ApplicationController
  def index
    # Put inactive items last?
    @items = Item.order(:active)

    # Only admins see inactive items
    @items = @items.active if (!logged_in? || (logged_in? && !current_user.role?(:admin)))
    # Filter by category if given a typ
    @items = @items.for_category(params[:type]) if params[:type]

    @type = params[:type]
  end

  def show
    @item = Item.find(params[:id])

    # For everyone else, show similar products
    # Exclude the current item if it's also on the list
    @similar_items = Item.for_category(@item.category).active.where.not(id: params[:id])

    # Include empty item price to fill the form 
    @new_price = ItemPrice.new
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    if params[:item_price] #updating price
      update_item_price and return
    elsif params[:item]
      "blah"
    end
  end

  def destroy
  end



  private
  def update_item_price
    price = ItemPrice.new(item_price_params)

    if price.save
      flash[:notice] = "Successfully updated price to #{price.price}"
    else
      # redirect_to price.item, alert: 'Price not updated'
      # render price.item, alert: 'Price not updated'
      flash[:alert] = 'Could not change price'
    end

    redirect_to price.item 
  end

  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
  end
end
