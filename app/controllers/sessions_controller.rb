class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if @user
      session[:id] = @user.id
      redirect_to "/groups"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/main"
    end
  end
  def destroy
    session[:id] = nil
    redirect_to "/main"
  end
end
