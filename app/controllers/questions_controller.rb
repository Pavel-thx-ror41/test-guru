class QuestionsController < ApplicationController
  before_action :set_test, only: %i[index new create]
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = @test.questions
  end

  def show; end

  def new
    @question = @test.questions.new
  end

  def edit; end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      flash[:notice] = 'Question created'
      redirect_to action: 'index'
    else
      flash[:notice] = { errors: entity_errors_list(@question) }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = 'Question created'
      redirect_to @question # , notice: 'Question updated'
    else
      flash[:notice] = { errors: entity_errors_list(@question) }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    question = @question.destroy

    flash[:notice] = if question.frozen? && !question.persisted?
                       'Question was successfully destroyed.'
                     else
                       'Question was NOT destroyed.'
                     end
    redirect_to action: 'index', test_id: question.test_id
  end

  private

  def question_params
    params.require(:question).permit(:title, :info)
  end

  def set_test
    @test = Test.find(params[:test_id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Test not found'
    @questions = nil
    render action: 'index'
  end

  def set_question
    @question = Question.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Question not found'
    redirect_to action: 'index', test_id: params[:test_id]
  end
end
