class GroupsController < ApplicationController
  before_action :set_group, only: [ :show, :edit, :update, :notice, :send_notice ]
  before_action :ensure_owner!, only: [ :edit, :update, :notice, :send_notice ]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = Current.user

    if @group.save
      GroupUser.create!(
        user: Current.user,
        group: @group
      )
      redirect_to @group, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "更新しました"
    else
      render :edit
    end
  end

  def notice
    @group = Group.find(params[:id])
  end

  def send_notice
    @group = Group.find(params[:id])
    @group.users.each do |user|
      GroupMailer.notice_email(user, @group, params[:title], params[:body]).deliver_now
    end
    @title = params[:title]
    @body = params[:body]

    render :send_notice
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_owner!
    unless @group.owner == Current.user
      redirect_to groups_path, alert: "権限がありません"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
