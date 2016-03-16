class AnswersController < ApplicationController

  # URL groups/group_id/question/question_id/answers
  # nested under question
  def index
  @answers = Answer.all
  end

  def create
  @answer = Answer.new(answer_params)
  @answer.question_id = params[:question_id]
  @answer.user = current_user
  @answer.save
  @group = Group.find(params[:group_id])
  @question = Question.find(params[:question_id])
  redirect_to group_question_path(@group, @question)
  end 

  def edit
    @answer = Answer.find(params[:id])
    @group = @question.group
    #@user = User.find(session[:id])
    @user = @question.user
  end

  def update

  end

  def destroy
  end

  private

  def answer_params
  params.require(:answer).permit(:content, :question, :group)
  end

end