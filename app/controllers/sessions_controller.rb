class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      if @user.admin_of_groups.any?
      redirect_to admin_path(@user), notice: "Logged In"
      else
        redirect_to home_path
      end
    else
      flash.now.alert = "Email or password is invalid!"
      render :new
    end
  end

  def destroy
    session[:id] = nil
    redirect_to home_path, notice: "Logged Out"
  end
end
