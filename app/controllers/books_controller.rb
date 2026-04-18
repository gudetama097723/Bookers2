class BooksController < ApplicationController
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id

    if @book.save
      redirect_to user_path(Current.user)
    else
      @user = Current.user
      @books = @user.books
      render "users/show" 
    end
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
