class Admin::GistsController < Admin::BaseController
  before_action :set_test_passage, only: %i[create]

  def index
    @gists = Gist.all
  end

  def create
    new_github_gist = GistQuestionService.new(@test_passage.current_question).create

    if new_github_gist
      current_user.gists.create({ question: @test_passage.current_question,
                                  gist_url: new_github_gist[1] })
      flash_options = { notice: "#{t('.success')}: #{helpers.link_to(*new_github_gist)}" }
    else
      flash_options = { alert: "#{t('.failure')}" }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def gist_logged_locally?(new_gist_local_log)
    new_gist_local_log&.persisted?
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
