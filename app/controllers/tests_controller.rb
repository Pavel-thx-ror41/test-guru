class TestsController < ApplicationController
  before_action :set_test, only: %i[show edit update destroy start]
  before_action :set_user, only: :start

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)
    @test.user_id = User.first.id

    if @test.save
      flash[:notice] = 'Test created'
      redirect_to tests_path
    else
      flash.now[:alert] = { errors: entity_errors_list(@test) }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @test.update(test_params)
      flash[:notice] = 'Test updated'
      redirect_to tests_path
    else
      flash.now[:alert] = { errors: entity_errors_list(@test) }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    test = @test.destroy

    flash[:notice] = if test.frozen? && !test.persisted?
                       'Test was successfully destroyed.'
                     else
                       'Test was NOT destroyed.'
                     end
    redirect_to tests_path
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:category_id, :published, :level, :title, :info)
  end

  def set_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Test not found'
    redirect_to tests_path
  end
end
