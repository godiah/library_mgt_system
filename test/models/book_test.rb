require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = books(:moby_dick)
    @user = users(:john)
  end

  test "should be valid with all attributes" do
    assert @book.valid?
  end

  test "title must be present" do
    @book.title = ""
    assert_not @book.valid?, "Book is valid without a title"
  end

  test "author must be present" do
    @book.author = ""
    assert_not @book.valid?, "Book is valid without an author"
  end

  test "isbn must be present" do
    @book.isbn = ""
    assert_not @book.valid?, "Book is valid without an ISBN"
  end

  test "isbn should be unique" do
    duplicate_book = @book.dup
    @book.save!
    assert_not duplicate_book.valid?, "Duplicate ISBN accepted"
  end

  test "borrowed_by? returns false if user has not borrowed the book" do
    other_book = Book.create!(title: "Other Book", author: "Other Author", isbn: "1111111111111")
    assert_not other_book.borrowed_by?(@user), "Book incorrectly marked as borrowed by user"
  end

  test "borrowed_by? returns true if user has an active loan" do
    Loan.create!(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    assert @book.borrowed_by?(@user), "Book should be marked as borrowed by the user"
  end

  test "current_loan_for returns the correct loan for a user" do
    new_book = Book.create!(title: "New Book", author: "New Author", isbn: "1111111111111")
    loan = Loan.create!(user: @user, book: new_book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    assert_equal loan, new_book.current_loan_for(@user), "Current loan for user not returned correctly"
  end
end
