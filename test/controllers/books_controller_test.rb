require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @book = books(:moby_dick)
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
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    assert_match "Borrowed", response.body
  end

  test "should not allow borrowing a book if already borrowed by current user" do
    Loan.create!(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    assert_match(/already borrowed/, flash[:alert].to_s)
  end

  test "should allow returning a borrowed book" do
    Loan.create!(user: @user, book: @book, borrowed_at: Time.current, due_date: Time.current + 2.weeks)
    post return_book_path(@book)
    assert_redirected_to book_path(@book)
    follow_redirect!
    assert_match "Available", response.body
  end
end
