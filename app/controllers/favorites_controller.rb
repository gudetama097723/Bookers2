class FavoritesController < ApplicationController
def create
  @book = Book.find(params[:book_id])
  Current.user.favorites.create!(book: @book)
  respond_to(&:turbo_stream)
end

def destroy
  @book = Book.find(params[:book_id])
  Current.user.favorites.find_by(book: @book)&.destroy
  respond_to(&:turbo_stream)
end

end
