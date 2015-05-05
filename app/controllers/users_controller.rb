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
    # @order_items = OrderItems.
  end

  def shipper
    
  end

end
