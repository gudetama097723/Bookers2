class SearchesController < ApplicationController
  def search
    @books = []
    @users = []

    if params[:tag].present?
      @books = Book.joins(:tags).where(tags: { name: params[:tag] })
      return
    end

    return unless params[:keyword].present?

    keyword = params[:keyword]
    method = params[:method]
    model = params[:model]

    if model == "user"
      @users = search_users(keyword,method)
    else
      @books = search_books(keyword,method)
    end
  end

  private

  def search_users(keyword,method)
    case method
    when "perfect"
      User.where(name: keyword)

    when "forward"
      User.where("name LIKE ?", "#{keyword}%")

    when "backward"
      User.where("name LIKE ?", "%#{keyword}")

    else
      User.where("name LIKE ?", "%#{keyword}%")
    end
  end

  def search_books(keyword, method)
    case method
    when "perfect"
      Book.where(title: keyword)

    when "forward"
      Book.where("title LIKE ?", "#{keyword}%")

    when "backward"
      Book.where("title LIKE ?", "%#{keyword}")

    else
      Book.where("title LIKE ?", "%#{keyword}%")
    end
  end

  def search_books_by_tag(tag_name)
    Book.joins(:tags).where(tags: { name: tag_name })
  end
end
