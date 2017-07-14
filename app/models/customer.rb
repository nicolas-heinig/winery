class Customer < ApplicationRecord
  searchkick language: 'german', word_start: [:first_name, :last_name]

  validates :first_name, :last_name, presence: true

  has_many :orders
  has_many :wines, through: :orders

  def full_name
    return '' if first_name.nil? || last_name.nil?

    first_name + ' ' + last_name
  end
end
