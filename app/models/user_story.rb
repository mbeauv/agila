class UserStory < ApplicationRecord
  belongs_to :project
  has_many :user_story_sprint_mappings, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :estimate, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  enum status: { not_started: 0, in_progress: 1, completed: 2, cancelled: 3, paused: 4 }

  before_validation :set_default_status, on: :create

  def set_default_status
    self.status ||= :not_started
  end

end
