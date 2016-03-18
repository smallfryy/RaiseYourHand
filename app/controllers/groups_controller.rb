# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    if current_user
      @group = Group.new
    else
      redirect_to login_path
    end
  end

  def create
    if current_user
      @group = Group.new(group_params)
      if @group.save
        status = Status.create(user_id: current_user.id, group_id: @group.id, status: "admin")
        @group.statuses << status
        redirect_to @group
      else
        render :new
      end
    else
      redirect_to home_path
    end
  end

  def show
    @group = Group.find(params[:id])
    @questions = @group.questions.order('questions.created_at desc')
  end

  def edit
    @group = Group.find(params[:id])
    @user = current_user
    redirect_to @group unless @group.admins.include?(@user)
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params) ? (redirect_to @group) : (render :edit)
    # if @group.update(group_params)
    #   redirect_to @group
    # else
    #   render :edit
    # end
  end

  def destroy
    @group = Group.find(params[:id])
    @user = current_user
    if @group.admins.include?(@user)
      @group = Group.find(params[:id])
      @group.destroy
      redirect_to home_path
    else
      redirect_to @group
      #add message
    end
  end

  def join
    redirect_to @group unless current_user
    @user = current_user
    @group = Group.find(params[:id])
    unless @group.users.include?(@user)
      status = Status.create(user_id: @user.id, group_id: @group.id, status: "pending")
      @user.statuses << status
      @group.statuses << status
    end
    redirect_to @group
  end

  def memberships
    redirect_to @group unless current_user
    @user = current_user
    @group = Group.find(params[:id])
    if @group.admins.include?(@user)
      @users = @group.pending
      render :membership
    else
      redirect_to @group
    end
  end

  def users
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def approve
    redirect_to @group unless current_user
    @group = Group.find(params[:id])
    @user = current_user 
    redirect to @group unless @group.admins.include?(@user)
    if params[:ids].present?
      params[:ids].each do |id|
        user = User.find(id)
        status = Status.find_by(user_id: user.id, group_id: @group.id)
        status.update(status: "member")
      end
    end
    redirect_to @group
  end


  private
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
