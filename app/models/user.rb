class User < ActiveRecord::Base
  has_secure_password
  has_many :activities

  validates :email, uniqueness: true, presence: true
end
