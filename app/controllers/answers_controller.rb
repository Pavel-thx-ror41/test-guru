class AnswersController < ApplicationController
  before_action :find_question, only: %i[new create]
  before_action :set_answer, only: %i[show edit update destroy]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question, notice: 'Answer was successfully created.'
    else
      flash.now[:notice] = { errors: entity_errors_list(@answer) }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer, notice: 'Answer was successfully updated.'
    else
      flash.now[:notice] = { errors: entity_errors_list(@answer) }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    answer = @answer.destroy

    flash[:notice] = if answer.frozen? && !answer.persisted?
                       'Answer was successfully destroyed.'
                     else
                       'Aanswer was NOT destroyed.'
                     end
    redirect_to @answer.question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:info, :title, :correct)
  end
end
