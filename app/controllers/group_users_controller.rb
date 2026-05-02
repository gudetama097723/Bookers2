class GroupUsersController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    group.group_users.create(user: Current.user)
    redirect_to group
  end

  def destroy
    group = Group.find(params[:group_id])
    group_user = group.group_users.find_by(user: Current.user)
    group_user.destroy
    redirect_to group
  end
end
