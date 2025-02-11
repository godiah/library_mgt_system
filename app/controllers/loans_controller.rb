class LoansController < ApplicationController
  before_action :require_login

  def index
    @loans = Current.user.loans.where(returned_at: nil)
  end

  def return
    @loan = Loan.find(params[:id])
    if @loan.user == Current.user && @loan.active?
      @loan.update(returned_at: Time.current)
      flash[:notice] = "Successfully returned #{@loan.book.title}."
    else
      flash[:alert] = "Unable to return this book."
    end
    redirect_to loans_path
  end

  private

  def require_login
    unless Current.user
      flash[:alert] = "You must be signed in."
      redirect_to sign_in_path
    end
  end
end
