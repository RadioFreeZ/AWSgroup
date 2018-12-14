class GroupsController < ApplicationController
  def index
    @user = User.find(session[:id])
    @groups = Group.all
  end
  def create
    @group = Group.new(name: params[:name], description: params[:description], owner: session[:id])
    if @group.save
      Membership.create(user: User.find(session[:id]), group: @group)
      redirect_to "/groups"
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to "/groups"
    end
  end
  def show
    @user = User.find(session[:id])
    @group = Group.find(params[:id])
    @users = @group.users
    @owner = User.find(@group.owner)
    if @group.owner = session[:id]
      @owner_in_session = true
    else
      @owner_in_session = false
    end
    check = @users.where(id: session[:id])
    if check.length >= 1
      @member = true
    else
      @member = false
    end
  end
  def destroy
    group = Group.find(params[:id])
    group.delete
    redirect_to "/groups"
  end
  def member_create
    Membership.create(user: User.find(session[:id]), group: Group.find(params[:id]))
    redirect_to "/groups/#{params[:id]}"
  end
  def member_delete
    memberships = Membership.where(group_id: params[:id])
    if memberships.length > 1
      membership = memberships.where(user_id: session[:id])
    else
      membership = memberships
    end
    p "THIS IS THE MEMBERSHIP"
    p "MEMBERSHIP IS #{membership}"
    Membership.delete(membership)
    redirect_to "/groups/#{params[:id]}"
  end
end
