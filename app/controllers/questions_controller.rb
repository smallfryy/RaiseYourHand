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
    #binding.pry 
    @group = Group.find(params[:group_id])
    @user = User.find(session[:id])
    @question = @group.questions.build(question_params)
    @question.user =  @user
    if @question.save
       if params[:tag_name].present?
         tag = Tag.find_or_create_by(name: params[:tag_name])
         @question.tags << tag unless @question.tags.include?(tag)
       end
      redirect_to group_question_path(@question.group, @question)
    else
      # binding.pry
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    # creating new instance of answer and rendering view
    @answer = Answer.new 
    @answer.question = @question
    @answer.user = current_user
    @group = @question.group
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
      if params[:tag_name].present?
         tag = Tag.find_or_create_by(name: params[:tag_name])
         @question.tags << tag unless @question.tags.include?(tag)
       end
      redirect_to group_question_path(@question.group, @question)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @group = @question.group
    if current_user == @question.user
      @question.destroy
      redirect_to group_path(@group)
    else
      redirect_to @group
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :group_id, :user_id, :tag_ids => [])
  end
end
