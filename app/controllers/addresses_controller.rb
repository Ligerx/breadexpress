class AddressesController < ApplicationController
  before_action :check_login
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    # if current_user.role? :customer
    #   @active_addresses = current_user.customer.addresses.active.by_recipient.paginate(:page => params[:page]).per_page(10)
    #   @inactive_addresses = current_user.customer.addresses.inactive.by_recipient.paginate(:page => params[:page]).per_page(10)      
    # else
    #   @active_addresses = Address.active.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
    #   @inactive_addresses = Address.inactive.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
    # end

    if current_user.role? :customer
      @addresses = current_user.customer.addresses.by_recipient
    elsif current_user.role? :admin
      if params[:admin_request]
        @customer = Customer.find(params[:admin_request])
        @addresses = @customer.addresses.by_recipient
      else
        @addresses = Address.by_recipient.paginate(:page => params[:page]).per_page(10)
      end
    end
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    
    if @address.save
      redirect_to addresses_path, notice: "The address was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: "The address was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_url, notice: "The address was removed from the system."
  end


  def deactivate
    address = Address.find(params[:id])
    address.update(active: false)
puts "IN DEACTIVATE"
    flash[:notice] = 'Successfully deactivated address'
    redirect_to :back
  end

  def activate
    address = Address.find(params[:id])
    address.update(active: true)
puts "IN ACTIVATE"
    flash[:notice] = 'Successfully activated address'
    redirect_to :back
  end


  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    set_customer_id
    params.require(:address).permit(:recipient, :street_1, :street_2, :city, :state, :zip, :active, :is_billing, :customer_id)
  end

  def set_customer_id
    unless current_user.role?(:admin)
      params[:address][:customer_id] = current_user.customer.id
    end
  end

end