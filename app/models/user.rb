# email:string
# password_digest:string
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a alid email address" },
              uniqueness: true
end
