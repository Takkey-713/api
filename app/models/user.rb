class User < ApplicationRecord
  has_secure_password
  has_many :boards
  has_many :lists
  has_many :tasks

  validates :email , presence: true, uniqueness: true, on: :create,  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { in: 6..20 }, format: {with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/}
  

end
