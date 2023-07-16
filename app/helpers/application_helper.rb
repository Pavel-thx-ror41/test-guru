module ApplicationHelper
  def last_edition
    2023
  end

  def github_url(author, repo)
    link_to "исходник на GitHub: #{repo}", "https://github.com/#{author}/#{repo}", target: 'blank'
  end
end
