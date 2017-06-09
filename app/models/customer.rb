class Customer < ApplicationRecord
  searchkick language: 'german'

  validates :first_name, :last_name, :phone, presence: true

  has_many :orders
  has_many :wines, through: :orders

  def full_name
    first_name + ' ' + last_name
  end
end
