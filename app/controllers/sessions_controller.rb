class SessionsController < ApplicationController
  include BreadExpressHelpers::Cart 

  def new
    if session[:user_id]
      flash[:alert] = "You're already logged in"
      redirect_to :back and return
    end

    track_redirect_back_url
  end

  def create
    create_cart

    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id

      flash[:notice] = "Welcome back #{user.customer.first_name}!" if user.role? :customer
      flash[:notice] = "Successfully logged in!" if !user.role? :customer

      redirect_back and return
    else
      flash.now[:alert] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
puts "Am I logged in as user #{session[:user_id]} ?----------------------"
    if session[:user_id]
      # session.delete(:user_id)
puts "DELETING USER_ID"
      session[:user_id] = nil
puts "User_id should have been deleted. #{session[:user_id].nil?}"
      destroy_cart
      flash[:notice] = 'Successfully logged out'
    end
puts "End of destroy, user_id is #{session[:user_id].nil?} #{session[:user_id]}"
    redirect_to root_path
  end



  private
  def track_redirect_back_url
    if request.referer != signup_url && new_login_url && login_url
      session[:return_to] = request.referer
    end
  end

  def redirect_back
    if session[:return_to]
      redirect_to session.delete(:return_to) #redirect back
    else
      redirect_to root_path
    end
  end
end
