module ApplicationHelper
  def last_edition
    2023
  end

  def github_url(author, repo)
    link_to "исходник на GitHub: #{repo}", "https://github.com/#{author}/#{repo}", target: 'blank'
  end

  def to_ul(list)
    "<ul><li><mark>#{list.join('</li></mark><li><mark>')}</mark></li></ul>".html_safe
  end

  def page_title
    title = instance_variable_get("@#{controller_name.singularize}")&.title.to_s
    case action_name
    when 'index'
      controller_name.capitalize
    when 'new'
      "#{action_name.capitalize} #{controller_name.singularize.capitalize}"
    when 'edit'
      "#{action_name.capitalize} #{controller_name.singularize.capitalize}: '#{title}'"
    when 'show'
      controller_name.singularize.capitalize
      "#{controller_name.singularize.capitalize}: '#{title}'"
    else
      'Welcome'
    end
  end
end
