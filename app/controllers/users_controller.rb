class UsersController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Baking

  authorize_resource

  helper_method :create_baking_list_for

  def index
    @users = User.all.paginate(:page => params[:page]).per_page(10)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Successfully created user"
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "Successfully updated user"
    else
      render 'edit'
    end
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


  private
  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :role, :active)
  end
end
