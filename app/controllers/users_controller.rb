# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

class UsersController < ApplicationController
  def index
    @users = User.all
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      #redirect_to @user
      redirect_to home_path, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params) ? (redirect_to @user) : (render :edit)
    # if @user.update(user_params)
    #   redirect_to @user
    # else
    #   render :edit
    # end
  end

  def admin
    @user = User.find(params[:id])
    if current_user && @user.admin_status.present?
      @groups = @user.admin_status
      render :admin
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
