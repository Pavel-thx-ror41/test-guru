class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = current_user.authored_tests.build(test_params)

    if @test.save
      redirect_to admin_tests_path, notice: t('.success')
    else
      flash.now[:alert] = { errors: entity_errors_list(@test) }
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      flash.now[:alert] = { errors: entity_errors_list(@test) }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    test = @test.destroy

    if test.frozen? && !test.persisted?
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_to admin_tests_path
  end

  private

  def test_params
    params.require(:test).permit(:category_id, :published, :level, :title, :info)
  end

  def set_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_tests_path, alert: t('.test_not_found')
  end
end
