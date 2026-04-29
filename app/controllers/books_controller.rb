class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = Current.user
      @books = Book.all
      @error_messages = @book.errors.full_messages
      render "books/index", status: :unprocessable_entity
    end
  end

  def index
    @books = Book
      .left_joins(:favorites)
      .group(:id)
      .order(Arel.sql("COUNT(CASE WHEN favorites.created_at >= '#{1.week.ago}' THEN 1 END) DESC"))
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == Current.user.id
      redirect_to books_path
    end
  end

end
