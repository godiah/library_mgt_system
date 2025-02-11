# email:string
# password_digest:string
class User < ApplicationRecord
  has_secure_password

  has_many :loans, dependent: :destroy
  has_many :borrowed_books, through: :loans, source: :book

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a alid email address" },
              uniqueness: true
  validates :password, presence: true,
                      length: { minimum: 6 },
                      confirmation: true
  validates :password_confirmation, presence: true
end
