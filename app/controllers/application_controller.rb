class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if !@current_user
      flash[:notice] = "ログインが必要です"
      redirect_to new_sessions_path
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to questions_path
    end
  end

  def ensure_correct_user
    @question = Question.find(params[:id])
    if @question.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to questions_path
    end
  end
end
