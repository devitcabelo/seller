class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :product, presence: true
  validates :user, presence: true
  validate :enough_quantity

  after_create :decrease_product_quantity
  after_update :decrease_product_quantity
  after_destroy :increase_product_quantity

  def enough_quantity
    if quantity - quantity_previously_was.to_i > product.quantity
      errors.add(:quantity, 'insufficient stock')
    end
  end

  def decrease_product_quantity
    if quantity_previously_was != quantity
      product.decrease_quantity(quantity - quantity_previously_was.to_i)
    end
  end

  def increase_product_quantity
    product.increase_quantity(quantity)
  end
end
