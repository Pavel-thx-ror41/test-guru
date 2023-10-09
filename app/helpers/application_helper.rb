module ApplicationHelper
  def last_edition
    2023
  end

  def github_url(author, repo)
    link_to "исходник на GitHub: #{repo}", "https://github.com/#{author}/#{repo}", target: 'blank'
  end

  def flash_html
    result = if flash[:alert].is_a?(Hash) && flash[:alert][:errors].present?
               "<div id='#{:alert}'><table><tr><td>#{flash[:alert][:errors].join('</td></tr><tr><td>')}</td></tr></table></div>"
             elsif flash[:alert].is_a?(String)
               "<div id='#{:alert}'>#{flash[:alert]}</div>"
             end.to_s

    result += if flash[:notice].is_a?(Hash) && flash[:notice][:errors].present?
                "<div id='#{:notice}'><table><tr><td>#{flash[:notice][:errors].join('</td></tr><tr><td>')}</td></tr></table></div>"
              elsif flash[:notice].is_a?(String)
                "<div id='#{:notice}'>#{flash[:notice]}</div>"
              end.to_s

    result.html_safe
  end

  def page_title
    begin
      title = instance_variable_get("@#{controller_name.singularize}")&.title.to_s
    rescue StandardError
      title = nil
    end

    case action_name
    when 'index'
      controller_name.capitalize
    when 'new'
      "#{action_name.capitalize} #{controller_name.singularize.capitalize}" unless controller_name.eql?('sessions')
    when 'edit'
      "#{action_name.capitalize} #{controller_name.singularize.capitalize}: '#{title}'" if title
    when 'show'
      "#{controller_name.singularize.capitalize}: '#{title}'" if title
    else
      title
    end
  end
end
