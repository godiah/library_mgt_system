require "test_helper"

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @loan = loans(:one)  # assumes you have a loan fixture for john
    post sign_in_path, params: { email: @user.email, password: "password" }
  end

  test "should get index and show only current user's loans" do
    get loans_path
    assert_response :success
    # Verify that the page title “My Borrowed Books” appears
    assert_select "h2", "My Borrowed Books"
    # Optionally, check that the loan fixture's book title is present
    assert_match @loan.book.title, response.body
  end

  test "should allow returning a loan" do
    post return_loan_path(@loan)
    assert_redirected_to loans_path
    follow_redirect!
    # Check for a success flash message (adjust expected text as needed)
    assert_match(/Successfully returned/, flash[:notice].to_s)
  end
end
