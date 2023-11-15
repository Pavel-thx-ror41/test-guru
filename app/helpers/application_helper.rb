module ApplicationHelper
  def last_edition
    2023
  end

  def github_url(author, repo)
    link_to "исходник на GitHub: #{repo}", "https://github.com/#{author}/#{repo}", target: 'blank'
  end

  def flash_html
    flash.map do |name, value|
      if value.is_a?(Hash) && value[:errors].present?
        "<div id='#{name}'><table><tr><td>#{value[:errors].join('</td></tr><tr><td>')}</td></tr></table></div>"
      elsif value.include?('#{')
        "<div id='#{name}'>#{interpolate(value)}</div>"
      else
        "<div id='#{name}'>#{value}</div>"
      end
    end.join.html_safe
  end

  def interpolate(value)
    eval('"'+value+'"')
  end

  def page_title
    case action_name
    when 'index', 'result', 'new'
      t("#{controller_path.gsub('/', '.')}.#{action_name}.page_title")
    when 'edit', 'show', 'update'
      t("#{controller_path.gsub('/', '.')}.#{action_name}.page_title") + entity_title
    else # TODO: возможно не используется, проверить
      entity_title
    end
  end

  def entity_title
    title = instance_variable_get("@#{controller_name.singularize}")&.title.to_s
    title.present? ? ": #{title}" : ""
  rescue StandardError
    nil
  end
end
