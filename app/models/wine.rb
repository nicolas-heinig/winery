class Wine < ApplicationRecord
  searchkick language: 'german'

  validates :name, :from, :wine_type, presence: true
  validates :bottle_price, :box_price, :year, presence: true, numericality: { greater_than: 0 }
  validates :volume, presence: true
end
