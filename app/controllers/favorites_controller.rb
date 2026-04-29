class FavoritesController < ApplicationController
  before_action :set_book, only: [:create, :destroy]
  def create
    @favorite = @book.favorites.create(user: Current.user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer}
    end
  end

  def destroy
    @favorite = @book.favorites.find_by(user: Current.user)
    @favorite.destroy if @favorite

    respond_to do |format|
      format.turbo_stream
      format.html {redirect_to request.referrer}
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
