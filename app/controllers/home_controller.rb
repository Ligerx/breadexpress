class HomeController < ApplicationController
  include BreadExpressHelpers::Baking

  def home


  end

  def about
  end

  def privacy
  end

  def contact
  end


  def dashboard
    if !current_user.role?(:admin)
      redirect_to root_path
    else
      redirect_to users_path
    end
  end



end