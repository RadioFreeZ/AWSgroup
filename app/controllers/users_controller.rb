class UsersController < ApplicationController
  def new
  end
  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    if @user.save
      flash[:notice] = ['User successfully created']
      session[:id] = @user.id
      redirect_to "/groups"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/main"
    end
  end
end
