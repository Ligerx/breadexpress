class ShoppingController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Shipping
  
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

  def update
    new_cart = params[:cart]
    new_cart.delete_if { |item_id, quantity| quantity.to_i <= 0 }

    session[:cart] = new_cart

    redirect_to :cart, notice: 'Cart successfully updated'
  end

  # def new
  #   @order = Order.new
  # end

  # def create
  #   @order = Order.new(params[:order])

  #   if @order.save
  #     save_each_item_in_cart
  #     redirect_to checkout_success_path
  #     clear_cart
  #   else
  #     render 'new'
  #   end
  # end

  # def success
    
  # end

  helper_method :calculate_cart_items_cost
  helper_method :calculate_cart_shipping
end
