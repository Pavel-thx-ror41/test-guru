class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || GitHubClient.new
  end

  def create
    @client.create_gist(gist_params)
  end

  private

  def gist_params
    {
      description: @test.info,
      public: true,
      files: {
        "README.md": {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.info]
    content << ''
    content << 'answers:'
    content << @question.answers.pluck(:info)

    content.join("\n")
  end
end
