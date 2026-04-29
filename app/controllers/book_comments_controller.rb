class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user = Current.user

    if @book_comment.save
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to book_path(@book)}
    end
    else
    @book = Book.find(params[:book_id])
    render "books/show"
    end
  end

  def destroy
  @book = Book.find(params[:book_id])
  @book_comment = BookComment.find(params[:id])
  @book_comment.destroy

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to book_path(@book)}
  end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
