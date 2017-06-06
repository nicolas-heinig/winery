class Customer < ApplicationRecord
  searchkick language: 'german'

  validates :first_name, :last_name, :phone, presence: true


  def full_name
    first_name + ' ' + last_name
  end
end
