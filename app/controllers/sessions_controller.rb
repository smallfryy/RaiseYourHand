class SessionsController < ApplicationController
  
  def new
  end

  def create

    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      UserMailer.welcome_email(@user).deliver
      #redirect to admin panel if possible if admin
      if @user.admin_status.present?
      redirect_to admin_path(@user), notice: "Logged In"
      
        #redirect_to user_path(@user)
      else

        #redirect_to user_path(@user)
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
