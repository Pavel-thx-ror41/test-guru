class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @client = client || GitHubClient.new
  end

  # @return [Array] Newly created gist [description, url]
  # @return [String] If error Exception.message
  def create
    result = @client.create_gist(gist_params)

    return [result.description, result.html_url] if success?(result)

    result
  end

  private

  def success?(gist_create_result)
    gist_create_result.is_a?(Sawyer::Resource)
  end

  def gist_params
    {
      description: @question.title,
      public: true,
      files: {
        "README.md": {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.title]
    content << ''
    content << "#{I18n.t('admin.gists.answers')}\n"
    content << @question.answers.pluck(:title)

    content.join("\n")
  end
end
