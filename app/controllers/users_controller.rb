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
  #changed to allow checking and unchecking of items
  def update_order_items
    any_changed = false

    params[:shipped_order_items].each do |oi_id, check|
      oi = OrderItem.find(oi_id)

      #check is a string, so do string comparison
      if check == '1' && oi.shipped_on.nil?
        oi.update(shipped_on: Date.current) 
        any_changed = true

      elsif check == '0' && oi.shipped_on
        oi.update(shipped_on: nil) 
        any_changed = true
      end
    end

    if any_changed
      flash[:notice] = "Updated orders!"
    else
      flash[:alert] = "No items were changed"
    end

    redirect_to shipper_path
  end

end
