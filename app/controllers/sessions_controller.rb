class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_to home_path, notice: "Logged In"
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
