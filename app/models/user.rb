class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
