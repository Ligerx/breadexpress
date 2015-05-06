class CustomersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  before_action :check_login, except: [:new, :create]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    # @active_customers = Customer.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    # @inactive_customers = Customer.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
    @customers = Customer.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    # @previous_orders = @customer.orders.chronological
    if current_user.role?(:admin)
      @customer = Customer.find(params[:id])
    elsif current_user.role?(:customer)  
      @customer = current_user.customer
    end
  end

  def new
    @customer = Customer.new
    @customer.build_user
  end

  def edit
    # reformat phone w/ dashes when displayed for editing (preference; not required)
    @customer.phone = number_to_phone(@customer.phone)
    # should have a user associated with customer, but just in case...
    redirect_to @customer
  end

  def create
    reset_role_param
    @customer = Customer.new(customer_params)

    if @customer.save!
      #sign them in after account creation if new user
      session[:user_id] = @customer.user.id unless logged_in?
      redirect_to @customer, notice: "#{@customer.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    # just in case customer trying to hack the http request...
    reset_username_param unless (logged_in? && current_user.role?(:admin))
    if @customer.update(customer_params)
      # go back so that updating from either show or index should bring you back
      redirect_to :back, notice: "#{@customer.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    if params[:customer] && params[:customer][:user_attributes]
      fix_params = params[:customer][:user_attributes]
      fix_params[:active] = false if fix_params[:active] == '0'
      fix_params[:active] = true if fix_params[:active] == '1'
    end

    reset_role_param unless (logged_in? && current_user.role?(:admin))
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, 
                                      user_attributes: [:id, :username, :password, :password_confirmation, :role, :active])
  end

  def reset_role_param
    params[:customer][:user_attributes][:role] = "customer"
  end

  def reset_username_param
    params[:customer][:user_attributes][:username] = @customer.user.username
  end
end