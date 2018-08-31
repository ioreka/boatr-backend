class User < ApplicationRecord
  has_secure_password
  has_many :pins

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true
  validates :password, length: { in: 3..20 }
end
