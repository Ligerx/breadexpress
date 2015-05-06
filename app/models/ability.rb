class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    

    can :read, Item

    if user.role? :admin
      can :manage, :all

    elsif user.role? :baker
      can :baker, User

    elsif user.role? :shipper
      can :shipper, User

    elsif user.role? :customer
      can :manage, Address do |a|
        a.customer.user.id = user.id
      end

      can :show, Customer do |c|
        c.user.id = user.id
      end
      can :updates, Customer do |c|
        c.user.id = user.id
      end

      can :read, Order do |o|
        o.customer.user.id = user.id
      end
      can :create, Order do |o|
        o.customer.user.id = user.id
      end

    else
      can :read, :all
    end

  end
end