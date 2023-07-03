class Choice < ApplicationRecord
  belongs_to :pass
  belongs_to :question
  belongs_to :answer
end
