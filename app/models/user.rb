class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable

  enum role: { member: 0, admin: 1 }

  validates(
    :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }
  )

  # Attr and method for login with username or email
  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).find_by(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
    elsif conditions.key?(:username) || conditions.key?(:email)
      find_by(conditions.to_h)
    end
  end
end
