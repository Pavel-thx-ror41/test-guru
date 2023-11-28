class GitHubClient
  GITHUB_HTTP_ACCESS_TOKEN = ENV['GITHUB_HTTP_ACCESS_TOKEN']
  CREATED_STATUS = 201

  def initialize
    @octokit_client = Octokit::Client.new(access_token: GITHUB_HTTP_ACCESS_TOKEN)
  end

  def create_gist(params)
    @octokit_client.create_gist(params)
  rescue StandardError
    nil
  end

  def success?
    @octokit_client.last_response.status.eql?(CREATED_STATUS)
  end
end
