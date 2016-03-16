class QuestionsController < ApplicationController
  before_filter :authorize, only: [:edit, :update]

  def index
    @questions = Question.all
  end

  def new
    @group = Group.find(params[:group_id])
    @question = @group.questions.build
    @question.tags.build
  end

  def create
    @group = Group.find(params[:group_id])
    @user = User.find(session[:id])
    @question = @group.questions.build(question_params)
    @question.user =  @user
    if @question.save
      redirect_to group_question_path(@question.group, @question)
    else
      binding.pry
      render :new
    end

  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    @group = @question.group
    @user = User.find(session[:id])
    @user = @question.user
  end

  def update
    @question = Question.find(params[:id])
    @group = @question.group
     @user = User.find(session[:id])
    @user = @question.user
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
    redirect_to group_path(@group)
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :group_id, :user_id, :tag_name, :tag_ids => [])
  end
end
