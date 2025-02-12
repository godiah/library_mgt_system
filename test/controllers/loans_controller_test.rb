require "test_helper"

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @loan = loans(:one)
    post sign_in_path, params: { email: @user.email, password: "password" }
  end

  test "should get index and show only current user's loans" do
    get loans_path
    assert_response :success
    assert_select "h2", "My Borrowed Books"
    assert_match @loan.book.title, response.body
  end

  test "should allow returning a loan" do
    post return_loan_path(@loan)
    assert_redirected_to loans_path
    follow_redirect!
    assert_match(/Successfully returned/, flash[:notice].to_s)
  end
end
