class OrdersController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Shipping


  before_action :check_login
  before_action :set_order, only: [:show, :update, :destroy]
  # authorize_resource
  
  def index
    if logged_in? && current_user.role?(:admin)
      if params[:admin_request]
        @orders = Customer.find(params[:admin_request]).orders.chronological.order(updated_at: :desc).paginate(:page => params[:page]).per_page(4)
      else
        # render some other page
        @orders = Order.chronological.paginate(:page => params[:page]).per_page(10)
        render 'all_orders_index'
      end
    elsif logged_in? && current_user.role?(:customer)
      @orders = current_user.customer.orders.chronological.order(updated_at: :desc).paginate(:page => params[:page]).per_page(4)
    end 
  end

  def show
    # @order_items = @order.order_items.to_a
    if current_user.role?(:customer)
      # @previous_orders = current_user.customer.orders.chronological.to_a
    else
      # @previous_orders = @order.customer.orders.chronological.to_a
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.valid?
      @order.grand_total = calculate_cart_items_cost + calculate_cart_shipping
      @order.pay
      @order.save
puts '-------------- AT CREATE, BEFORE save-each_item_in_cart'
      save_each_item_in_cart @order
      redirect_to orders_path, notice: "Your order has been placed. Thanks for shopping at Bread Express!"
      clear_cart
    else
      render 'new'
    end
  end

  def success
    
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Your order was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy!
    redirect_to orders_url, notice: "This order was removed from the system."
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:date, :customer_id, :address_id, :credit_card_number, :expiration_year, :expiration_month)
  end







end