class Sprint < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
  validates_uniqueness_of :name, scope: :project_id

  # If the sprint is active, there must be a start date.
  validates :start_date, presence: true, if: :active?
  
  # If the sprint has an end date, it must be after the start date.
  validates_date :end_date, after: :start_date, allow_blank: true

  before_validation :set_default_active, on: :create

  private

  def set_default_active
    self.active ||= false
  end

end
