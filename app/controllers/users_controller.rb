class UsersController < ApplicationController
  include BreadExpressHelpers::Cart

  def index
  end

  def show
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


  def add_item_to_cart_wrapper
    cart_item = CartItem.new(params[:cart_item])

    if cart_item.valid?
      add_item_to_cart(cart_item.item, cart_item.quantity)
      # redirect_to 
    else

    end
  end
end
