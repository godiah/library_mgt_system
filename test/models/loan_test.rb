require "test_helper"

class LoanTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @book = books(:moby_dick)
    @loan = Loan.new(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
  end

  test "should be valid with valid attributes" do
    assert @loan.valid?
  end

  test "borrowed_at must be present" do
    @loan.borrowed_at = nil
    assert_not @loan.valid?, "Loan is valid without a borrowed_at date"
  end

  test "due_date must be present" do
    @loan.due_date = nil
    assert_not @loan.valid?, "Loan is valid without a due_date"
  end

  test "active? returns true when returned_at is nil" do
    @loan.returned_at = nil
    assert @loan.active?, "Loan is not active when returned_at is nil"
  end

  test "active? returns false when returned_at is set" do
    @loan.returned_at = Time.current
    assert_not @loan.active?, "Loan is active when returned_at is set"
  end
end
