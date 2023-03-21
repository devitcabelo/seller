class Product < ApplicationRecord
  has_many :purchases

  def can_be_purchased? quantity
    return true if quantity <= self.quantity
  end

  def decrease_quantity quantity
    update_attribute(:quantity, self.quantity - quantity)
  end

  def increase_quantity quantity
    update_attribute(:quantity, self.quantity + quantity)
  end
end
