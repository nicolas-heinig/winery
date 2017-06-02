class Wine < ApplicationRecord
  validates :name, :from, :wine_type, presence: true
  validates :volume, :bottle_price, :box_price, :year, presence: true, numericality: { greater_than: 0 }
end
