class AnswersController < ApplicationController
  layout 'main_table'
  before_action :authenticate_user

  def index
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(user_id: @current_user.id)
    @question_user = @question.user
    @answer_user = @answer.user
    @question_user_avatar = @question_user.profile.avatar.thumb
    @answer_user_avatar = @answer_user.profile.avatar.thumb
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(user_id: @current_user.id)
    @answer.attributes = answer_params
    if @answer.save
      redirect_to question_path(@question), notice: '回答しました'
    else
      render :new
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @answer_user = @answer.user
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @question_user = @question.user
    @answer_user = @answer.user
    @question_user_avatar = @question_user.profile.avatar.thumb
    @answer_user_avatar = @answer_user.profile.avatar.thumb
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.attributes = answer_params
    if @answer.save
      redirect_to question_path(@question), notice: '回答を編集しました'
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
