class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :wine

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
end
