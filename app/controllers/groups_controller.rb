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
        binding.pry
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
    @questions = @group.questions
  end

  def edit
    @group = Group.find(params[:id])
      @user = current_user
    unless @group.admins.include?(@user)
      redirect_to @group
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group
    else
      render :edit
    end
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

  private
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
