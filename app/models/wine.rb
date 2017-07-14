class Wine < ApplicationRecord
  searchkick language: 'german'

  validates :name, :bottle_price, :box_price, presence: true
  validates :bottle_price, :box_price, :year, :volume, numericality: { greater_than: 0 }
end
