class Admin::GistsController < Admin::BaseController
  before_action :set_test_passage, only: %i[create]

  def index
    @gists = Gist.all
  end

  def create
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

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
