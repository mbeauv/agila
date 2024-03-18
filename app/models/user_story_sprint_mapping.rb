class UserStorySprintMapping < ApplicationRecord
  belongs_to :user_story
  belongs_to :sprint

  validates :user_story, uniqueness: true
end
