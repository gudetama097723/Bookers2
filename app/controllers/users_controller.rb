class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
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

    @today_count = @books.where(created_at: Time.zone.today.all_day).count
    @yesterday_count = @books.where(created_at: 1.day.ago.all_day).count
    @day_ratio = 
      if @yesterday_count == 0
        nil
      else
        (@today_count.to_f / @yesterday_count * 100).round(1)
      end

    @this_week_count = @books.where(created_at: Time.zone.now.all_week).count
    @last_week_count = @books.where(created_at: 1.week.ago.all_week).count
    @week_ratio = 
      if @last_week_count == 0
        nil
      else
        (@this_week_count.to_f / @last_week_count * 100).round(1)
      end

    @past_7_days = (0..6).map { |i| Date.current - i }.reverse

    @posts_per_day = @past_7_days.map do |day|
      @user.books.where(created_at: day.all_day).count
    end
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
    if profile_image.attached?
      prpfile_image
    else
      "noimage.jpg"
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
  unless user.id == Current.user.id
    redirect_to user_path(Current.user)
  end

  end

end
