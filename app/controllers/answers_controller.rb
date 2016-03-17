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
    #fix???
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]
    @answer.user = current_user
    @answer.save
    @group = Group.find(params[:group_id])
    @question = Question.find(params[:question_id])
    redirect_to group_question_path(@group, @question)
  end 


  def edit
    #only render edit to owner of answer or admin of group!!!
    #binding.pry
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @group = @question.group
    redirect_to group_question_path(@question.group,@question, @answer) unless current_user == @answer.user
    #@user = @question.user
    #error couldnt find anser without id
  end

  def update

    #binding.pry
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
    #change to answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @group = @question.group
    if current_user == @answer.user
      @answer.destroy
      redirect_to group_question_path(@question.group, @question, @answer)
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:content, :question, :group)
  end

end
