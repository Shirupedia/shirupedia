class QuestionsController < ApplicationController
  before_action :authenticate_user

  def index
    @questions = Question.all
  end

  def new

  end

  def create
  end

  def show
  end

  def edit

  end

  def update
  end

  def destroy
  end

end