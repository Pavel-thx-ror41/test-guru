class GitHubClient
  GITHUB_HTTP_ACCESS_TOKEN = ENV['GITHUB_HTTP_ACCESS_TOKEN']
  CREATED_STATUS = 201
  NOT_CREATED_STATUSES = {
    304 => 'Not modified',
    403 => 'Forbidden',
    404 => 'Resource not found',
    422 => 'Validation failed, or the endpoint has been spammed'
  }.freeze
  UNKNOWN_ERROR = 'Unknown error'.freeze

  def initialize
    @octokit_client = Octokit::Client.new(access_token: GITHUB_HTTP_ACCESS_TOKEN)
  end

  # @return [Sawyer::Resource] Newly created gist info
  # @return [String] If error
  def create_gist(params)
    new_resource = @octokit_client.create_gist(params)
    last_response_status = @octokit_client.last_response.status

    return new_resource if success?

    case last_response_status
    when *NOT_CREATED_STATUSES.keys then NOT_CREATED_STATUSES[last_response_status]
    else UNKNOWN_ERROR
    end
  rescue StandardError => e
    e.message.to_s
  end

  def success?
    @octokit_client.last_response.status.eql?(CREATED_STATUS)
  end
end
