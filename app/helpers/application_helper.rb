module ApplicationHelper
  def last_edition
    2023
  end

  def github_url(author, repo)
    link_to "исходник на GitHub: #{repo}", "https://github.com/#{author}/#{repo}", target: 'blank'
  end

  def bootstrap_flash_class(level)
    # https://getbootstrap.com/docs/4.0/components/alerts/
    {
      notice: "alert alert-info",
      success: "alert alert-success",
      error: "alert alert-danger",
      alert: "alert alert-warning"
    }[level.to_sym] || "alert alert-secondary"
  end

  def flash_html
    if flash.count.positive?
      flash.map do |name, value|
        if value.is_a?(Hash) && value[:errors].present?
          "<div class='#{bootstrap_flash_class(name)}'><table>
            <tr><td>#{value[:errors].join('</td></tr><tr><td>')}</td></tr>
          </table></div>"
        elsif value.include?('#{')
          "<div class='#{bootstrap_flash_class(name)}'>#{interpolate(value)}</div>"
        else
          "<div class='#{bootstrap_flash_class(name)}'>#{value}</div>"
        end
      end.join.html_safe

    elsif resource&.errors.count.positive?
      "<div class='#{bootstrap_flash_class('alert')}'><table>
        <tr><td>#{resource.errors.full_messages.join('</td></tr><tr><td>')}</td></tr>
      </table></div>".html_safe

    end
  end

  def interpolate(value)
    eval('"'+value+'"')
  end

  def page_title
    case action_name
    when 'index', 'result', 'new', 'create'
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
