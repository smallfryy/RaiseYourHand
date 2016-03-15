class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to group_question_path(@question.group, @question)
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    @group = @question.group
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to group_question_path(@question.group, @question)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @group = @question.group
    @question.destroy
    redirect_to group_questions_path(@group)
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :group_id, :user_id)
  end
end
