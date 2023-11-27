class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: %i[show result gist update]

  def show; end

  def result; end

  def gist
    new_github_gist = GistQuestionService.new(@test_passage.current_question).create
    if new_github_gist.is_a? Array
      new_gist_local_log = Gist.create!({
                                question: @test_passage.current_question,
                                user: current_user,
                                gist_url: new_github_gist[1]
                              })
    end

    flash_options = if new_github_gist.is_a?(Array) && new_gist_local_log.persisted?
                      { notice: "#{t('.success')}: #{helpers.link_to(*new_github_gist)}" }
                    else
                      { alert: "#{t('.failure')}: #{new_github_gist}" }
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
end
