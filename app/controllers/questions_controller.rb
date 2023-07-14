class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Test.find(params[:test_id]).questions
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Test not found'
    @questions = nil
    render action: 'index'
  end

  def show; end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)

    respond_to do |format|
      format.html do
        if @question.save
          flash[:notice] = 'Question created'
          redirect_to action: 'index'
        else
          flash[:notice] = @question.errors.map { |e| [e.attribute, e.message].join(' ') }.to_sentence
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    question = @question.destroy

    respond_to do |format|
      format.html do
        flash[:notice] = if question.frozen? && !question.persisted?
                           'Question was successfully destroyed.'
                         else
                           'Question was NOT destroyed.'
                         end
        redirect_to action: 'index'
      end
    end
  end

  private

  def question_params
    test = Test.find_by(id: params[:test_id])
    return unless test

    params.require(:question).permit(:title, :info).merge(test_id: test.id)
  end

  def set_question
    @question = Question.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Question not found'
    redirect_to action: 'index'
  end
end
