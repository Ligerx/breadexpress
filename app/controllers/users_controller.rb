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
    redirect_to shipper_path, notice: "Updated orders"
  end

end
