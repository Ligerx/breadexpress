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
end
