# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @tagss = Tag.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @tag = Tag.new
  end

  # def create
  #   @tag = Tag.new(tag_params)
  #   if @tag.save
  #     session[:id] = @tag.id
  #     #redirect_to @tag
  #     redirect_to home_path, notice: "Thanks for signing up!"
  #   else
  #     render :new
  #   end
  # end

  def show
    @tag = Tag.find(params[:id])
    @questions = @tag.questions
  end

  # def destroy
  #   @tag = Tag.find(params[:id])
  #   @tag.destroy
  #   redirect_to tags_path
  # end

  # private
  # def tag_params
  #   params.require(:tag).permit(:name, :email, :password, :password_confirmation)
  # end
end