class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: %i[show result gist update]

  def show; end

  def result; end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).create
    flash_options = if result.success?
                      { notice: "#{t('.success')} #{gist_create_notice(result)}" }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def gist_create_notice(result)
    result_body = JSON.parse(result.body)
    # ActionView::Helpers::UrlHelper.link_to
    helpers.link_to(result_body["description"], result_body["html_url"])
  end
end
