class BooksController < ApplicationController
  before_action :require_login

  # Fetch and display all available books
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  # Borrow a book
  def borrow
    @book = Book.find(params[:id])
    if @book.borrowed_by?(Current.user)
      flash[:alert] = "You have already borrowed #{@book.title}."
    else
      Loan.create!(
        user: Current.user,
        book: @book,
        borrowed_at: Time.current,
        due_date: Time.current + 2.weeks
      )
      flash[:notice] = "You have successfully borrowed #{@book.title}."
    end
    redirect_to book_path(@book)
  end

  # Return a book
  def return
    @book = Book.find(params[:id])
    loan = @book.current_loan_for(Current.user)
    if loan
      loan.update(returned_at: Time.current)
      flash[:notice] = "Successfully returned #{@book.title}."
    else
      flash[:alert] = "You have not borrowed #{@book.title}."
    end
    redirect_to book_path(@book)
  end

  private

  def require_login
    unless Current.user
      flash[:alert] = "You must be signed in to access this section."
      redirect_to sign_in_path
    end
  end
end
