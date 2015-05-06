class ItemsController < ApplicationController
  def index
    # Put inactive items last?
    @items = Item.order(:active).alphabetical

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
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    # if @item.save
    #   redirect_to @item, notice: 'Item successfully updated'
    # else
    #   render 'edit'
    # end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Successfully created a new item!'
    else
      render 'new'
    end
  end

  def update
    if params[:item_price] #updating price
      update_item_price and return
    elsif params[:item]
      item = Item.find(params[:id])
      if item.update(item_params)
        redirect_to :back, notice: 'Updated item'
      else
        flash.now[:alert] = 'Problem updating item'
        render 'edit'
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to :back, notice: 'Successfully destroyed item'
    else
      redirect_to :back, notice: 'Item could not be destroyed'
    end
  end


  def admin_index
    @items = Item.alphabetical.order(:category).paginate(:page => params[:page]).per_page(4)
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
    params.require(:item_price).permit(:id, :item_id, :price, :start_date, :end_date)
  end

  def item_params
    params.require(:item).permit(:name, :description, :picture, :category, :units_per_item, :weight, :active)
  end
end
