class CartItem
  include ActiveModel::Model

  attr_accessor :item, :quantity

  validates_numericality_of :quantity
end