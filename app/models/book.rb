class Book < ApplicationRecord
  has_many :loans, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true

  def available?
    loans.none?(&:active?)
    # loans.none? { |loan| loan.returned_at.nil? }
  end

  def current_loan
    loans.find { |loan| loan.active? }
  end

  def borrowed_by?(user)
    loans.where(user: user, returned_at: nil).exists?
  end

  def current_loan_for(user)
    loans.find_by(user: user, returned_at: nil)
  end
end
