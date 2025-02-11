class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :borrowed_at, presence: true
  validates :due_date, presence: true

  # A loan is active if returned_at is nil
  def active?
    returned_at.nil?
  end
end
