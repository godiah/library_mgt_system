require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
  end

  test "should be valid" do
    assert @user.valid?
  end


  test "should have loans association" do
    assert_respond_to @user, :loans
  end

  test "borrowed_books association works" do
    book = books(:moby_dick)
    Loan.create!(user: @user, book: book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    assert_includes @user.borrowed_books, book, "Borrowed book not included in user's borrowed_books association"
  end
end
