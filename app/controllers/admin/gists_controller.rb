class Admin::GistsController < Admin::BaseController
  before_action :set_test_passage, only: %i[create]

  def index
    @gists = Gist.all
  end

  def create
    new_github_gist_creation_result = GistQuestionService.new(@test_passage.current_question).create

    if github_gist_created?(new_github_gist_creation_result)
      new_gist_local_log = current_user.gists.create({ question: @test_passage.current_question,
                                                       gist_url: new_github_gist_creation_result[1] })
    end

    flash_options = if gist_logged_locally?(new_gist_local_log)
                      { notice: "#{t('.success')}: #{helpers.link_to(*new_github_gist_creation_result)}" }
                    elsif github_gist_created?(new_github_gist_creation_result)
                      { alert: "#{t('.failure')}: Gist created, but not logged locally" }
                    else
                      { alert: "#{t('.failure')}: #{new_github_gist_creation_result}" }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def github_gist_created?(new_github_gist)
    new_github_gist.is_a?(Array)
  end

  def gist_logged_locally?(new_gist_local_log)
    new_gist_local_log.persisted?
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
