class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]


  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to user_path(@user), notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = Current.user
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "You have updated user successfully."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def get_image(width, height)
    if image.attached?
      image
    else
      "noimage.jpg"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :image)
  end
end
