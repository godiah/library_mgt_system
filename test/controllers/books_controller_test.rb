require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @book = books(:moby_dick)
    # Sign in the user (adjust parameters as needed; assume fixture password is 'password')
    post sign_in_path, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get books_path
    assert_response :success
    assert_select "h3", @book.title
  end

  test "should show book details" do
    get book_path(@book)
    assert_response :success
    assert_select "h2", @book.title
  end

  test "should allow borrowing a book if not already borrowed by current user" do
    # Ensure the user has not borrowed this book yet
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    # The status badge should show "Borrowed" now (for current user)
    assert_match "Borrowed", response.body
  end

  test "should not allow borrowing a book if already borrowed by current user" do
    # Borrow once
    Loan.create!(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    # Check that a flash alert was set
    assert_match(/already borrowed/, flash[:alert].to_s)
  end

  test "should allow returning a borrowed book" do
    # Borrow the book first
    Loan.create!(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    post return_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    # Now the status should show Available
    assert_match "Available", response.body
  end
end
