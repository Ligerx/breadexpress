class ShoppingController < ApplicationController
  include BreadExpressHelpers::Cart

  def cart
  end

  def add_item_to_cart_wrapper
    cart_item = CartItem.new(params[:cart_item])

    if cart_item.valid?
      add_item_to_cart(cart_item.item, cart_item.quantity)
      redirect_to cart_path, notice: 'Successfully added to cart'
    else
      redirect_to :back, alert: 'Please enter a valid quantity'
    end
  end
end
