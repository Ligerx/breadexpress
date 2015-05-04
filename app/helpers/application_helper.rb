module ApplicationHelper
  def get_address_options(user=nil)
    if user.nil? || user.role?(:admin)
      addresses = Address.active.by_recipient.to_a
    else
      addresses = user.customer.addresses.by_recipient.to_a
    end
    addresses.map{|addr| ["#{addr.recipient} : #{addr.street_1}", addr.id] }
  end


  def print_date(date)
  	return '--------' if date.nil?

    date.strftime "%-m/%-d/%Y"
  end

  def cart_size
    return 0 if session[:cart].nil?

    total = 0
    session[:cart].each { |k,v| total += v.to_i }
    return total
  end

  def current_path?(path)
    # If this selection is a link to the current page
    # then add a class to it
    if current_page?(path)
      'current_page'
    else
      nil
    end
  end

  def all_shipped?(order)
    order.order_items.each do |oi|
      return false unless oi.shipped_on
    end

    return true
  end

  def all_unshipped?(order)
    order.order_items.each do |oi|
      return false if oi.shipped_on
    end

    return true
  end

end
