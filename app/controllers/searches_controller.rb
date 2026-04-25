class SearchesController < ApplicationController
  def search
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
end
