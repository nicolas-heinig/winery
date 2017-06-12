class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :wine

  validates :customer_name, :wine_name, presence: true
  validate :at_least_one_box_or_bottle_ordered

  def shipped?
    shipped
  end

  def full_price
    wine.box_price * boxes + wine.bottle_price * bottles
  end

  def boxes_price
    wine.box_price * boxes
  end

  def bottle_price
    wine.bottle_price * bottles
  end

  def customer_name
    customer.full_name if customer
  end

  def wine_name
    wine.name if wine
  end

  private

  def at_least_one_box_or_bottle_ordered
    if boxes + bottles <= 0
      errors.add(:boxes, 'Muss größer 0 sein.') if boxes <= 0
      errors.add(:bottles, 'Muss größer 0 sein.') if bottles <= 0
    end
  end
end
