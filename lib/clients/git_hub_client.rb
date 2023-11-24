class GitHubClient
  GITHUB_HTTP_ACCESS_TOKEN = ENV['GITHUB_HTTP_ACCESS_TOKEN']

  def initialize
    @octokit_client = Octokit::Client.new(access_token: GITHUB_HTTP_ACCESS_TOKEN)
  end

  # @return [Sawyer::Resource] Newly created gist info
  # @return [Exception] If error
  def create_gist(params)
    @octokit_client.create_gist(params)
  rescue StandardError => e
    e
  end
end
