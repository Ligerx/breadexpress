class UsersController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Baking

  helper_method :create_baking_list_for

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end


  def baker
  end

  def shipper
    @unshipped_orders = Order.not_shipped.chronological
  end

  #lol don't know where to put it cause there's no orderitem controller
  def update_order_items
    any_checked = false

    params[:shipped_order_items].each do |oi_id, check|
      #check is a string, so do string comparison
      if check == '1'
        oi = OrderItem.find(oi_id)
        oi.update(shipped_on: Date.current) 
        any_checked = true
      end
    end

    if any_checked
      flash[:notice] = "Updated orders!"
    else
      flash[:alert] = "No items were marked as shipped"
    end
    
    redirect_to shipper_path
  end

end
