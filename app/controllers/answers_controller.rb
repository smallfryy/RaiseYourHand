# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswersController < ApplicationController
  # URL groups/group_id/question/question_id/answers
  # nested under question
  def index
    @answers = Answer.all
  end

  def new
    @answer = Answer.new
  end

  def create

    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]
    @answer.user = current_user
    @answer.save
    @group = Group.find(params[:group_id])
    @question = Question.find(@answer.question_id)
    redirect_to group_question_path(@group, @question)
  end 


  def edit
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @group = @question.group
    redirect_to group_question_path(@question.group,@question, @answer) unless current_user == @answer.user
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @group = @question.group
    
    @user = @answer.user
    if @answer.update(answer_params)
      redirect_to group_question_path(@question.group,@question, @answer)
    else
      render :edit
    end
  end

  def destroy
    #update to allow group admin to delete answers
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @group = @question.group
    if current_user == @answer.user || @group.admins.include?(current_user)
      @answer.destroy
      redirect_to group_question_path(@question.group, @question, @answer)
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:content, :question, :group)
  end

end
