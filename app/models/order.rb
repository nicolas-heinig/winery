class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :wine

  def shipped?
    shipped
  end

  def full_price
    price = wine.box_price * boxes + wine.bottle_price * bottles
    price.to_s + ' €'
  end

  def boxes_price
  end

  def bottle_price
  end
end
