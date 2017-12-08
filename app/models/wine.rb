class Wine < ApplicationRecord
  searchkick language: 'german', word_start: [:id, :name]

  validates :name, :bottle_price, :box_price, presence: true
  validates :bottle_price, :box_price, numericality: { greater_than: 0 }
end
