class Admin::QuestionsController < Admin::BaseController
  before_action :set_test, only: %i[new create]
  before_action :set_question, only: %i[show edit update destroy]

  def new
    @question = @test.questions.new
  end

  def edit; end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      flash[:notice] = 'Question created'
      redirect_to edit_admin_test_path(@test)
    else
      flash.now[:alert] = { errors: entity_errors_list(@question) }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = 'Question updated'
      redirect_to edit_admin_test_path(@question.test)
    else
      flash.now[:alert] = { errors: entity_errors_list(@question) }
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
    redirect_to edit_admin_test_path(@question.test)
  end

  private

  def question_params
    params.require(:question).permit(:title, :info)
  end

  def set_test
    @test = Test.find(params[:test_id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = 'Test not found'
    @questions = nil
    redirect_to admin_tests_path
  end

  def set_question
    @question = Question.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Question not found'
    redirect_to admin_tests_path
  end
end
