class Test < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :questions
  has_many :passes

  class << self
    # отсортированный по убыванию массив названий Тестов с выбранной Категорией
    def titles_by_category_title_desc(category_title)
      joins(:category)
        .where(categories: { title: category_title })
        .order('tests.title DESC')
        .pluck('tests.title')
    end
  end
end
