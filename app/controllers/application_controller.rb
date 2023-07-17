class ApplicationController < ActionController::Base
  def entity_errors_list(entity)
    entity.errors.map { |e| [e.attribute, e.message].join(' ') }
  end
end
