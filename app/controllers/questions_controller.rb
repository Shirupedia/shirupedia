class QuestionsController < ApplicationController
  layout 'main_table'
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @questions = Question.includes([:fields, user: :profile]).order('created_at desc')
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: '質問を作成しました'
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user).order('created_at desc')
    @question_user = @question.user
    @avatar = @question_user.profile.avatar.thumb
    @answered_by_me = @answers.find_by(user_id: @current_user.id)
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: '質問を編集しました'
    else
      render :edit
    end
  end

  def destroy
  end

  def fire
    @question = Question.find(params[:id])
    @question.aasm.fire!(params[:event].to_sym)
    @question.save
    redirect_to question_path(@question), notice: '質問を終了しました'
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :amount_paid, :tag, :field_list, :file, :file_cache)
  end

end
