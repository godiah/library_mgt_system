require "test_helper"

class LoansViewTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    post sign_in_path, params: { email: @user.email, password: "password" }
    @loan = Loan.create!(user: @user, book: books(:moby_dick), borrowed_at: Time.current, due_date: Time.current + 2.weeks)
  end

  test "loans index displays borrowed books" do
    get loans_path
    assert_response :success
    assert_select "h2", "My Borrowed Books"
    assert_match @loan.book.title, response.body
    assert_select "p", /Due Date:/
  end
end
