class Category < ApplicationRecord
  has_many :tests

  validates :title, :info, presence: true

  default_scope { order(title: :asc) }
end
