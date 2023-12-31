class Test < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :user_id, :category_id, :level, :title, :info, presence: true
  validates :published, inclusion: { in: [false, true] }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :level, uniqueness: { scope: :title,
                                  message: I18n.t('activerecord.errors.messages.only_one_test_w_same_title_and_level') }

  scope :by_level, ->(level) { where(level: level) }
  scope :by_level_easy, -> { by_level(0..1) }
  scope :by_level_medium, -> { by_level(2..4) }
  scope :by_level_difficult, -> { by_level(5..) }
  scope :by_category_title, ->(category_title) { joins(:category).where(categories: { title: category_title }) }

  class << self
    # отсортированный по убыванию массив названий Тестов с выбранной Категорией
    def titles_by_category_title_desc(category_title)
      by_category_title(category_title).order('tests.title DESC').pluck('tests.title')
    end
  end
end
