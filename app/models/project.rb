# Create Project model
class Project < ApplicationRecord

    enum status: { not_started: 0, in_progress: 1, completed: 2, cancelled: 3, paused: 4 }
 
    # Name of the project (unique and min length of 3 and max lenght of 100)
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 100 }
 
    # Description of the project (max length of 1000)
    validates :description, length: { maximum: 1000 }

    # Start date of the project (optional when status is not_started, required otherwise)
    validate :start_date_required_when_started

    # End date of the project (optional but if present it must be after start_date)
    validates_date :end_date, after: :start_date, allow_blank: true

    # Status of the project (not_started, in_progress, completed, cancelled, paused)
    validates :status, presence: true, inclusion: { in: Project.statuses.keys }
 
    # Scopes
    scope :not_started, -> { where(status: 'not_started') }
    scope :in_progress, -> { where(status: 'in_progress') }
    scope :completed, -> { where(status: 'completed') }
    scope :cancelled, -> { where(status: 'cancelled') }
    scope :paused, -> { where(status: 'paused') }
 
    # Callbacks
    before_validation :set_default_status, on: :create
 
    # Methods
    def set_default_status
      self.status ||= :not_started
    end
 
    def status_name
      status.titleize
    end
 
    def status_name=(new_status)
      self.status = new_status
    end
 
    def to_s
      name
    end
 
    def completed?
      status == 'completed'
    end
 
    def in_progress?
      status == 'in_progress'
    end
 
    def not_started?
      status == 'not_started'
    end
 
    def cancelled?
      status == 'cancelled'
    end
 
    def paused?
      status == 'paused'
    end
 
    def status_color
      case status
      when 'not_started'
        'secondary'
      when 'in_progress'
        'primary'
      when 'completed'
        'success'
      when 'cancelled'
        'danger'
      when 'paused'
        'warning'
      end
    end
 
    def status_icon
      case status
      when 'not_started'
        'fa-hourglass-start'
      when 'in_progress'
        'fa-hourglass-half'
      when 'completed'
        'fa-hourglass-end'
      when 'cancelled'
        'fa-ban'
      when 'paused'
        'fa-pause'
      end
    end

    def start_date_required_when_started
        if status != "not_started" && start_date.blank?
          errors.add(:start_date, "is required when status is '#{status}'")
        end
    end 
      
  end