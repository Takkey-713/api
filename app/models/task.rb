class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
  belongs_to :list
  validates :name , presence: true
end
