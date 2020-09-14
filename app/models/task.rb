class Task < ApplicationRecord
  validates :content, presence: true
  validate :date_cannot_earlier_than_today, on: :create

  belongs_to :project
  has_one :assignment, dependent: :destroy
  accepts_nested_attributes_for :assignment, reject_if: proc { |attributes| attributes['user_id'].blank? }

  #self join
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task", optional: true

  #validation method
  def date_cannot_earlier_than_today
    if deadline < Time.zone.today
      errors.add(:deadline, "can't be set in the past")
    end
  end

  def human_time
    self.deadline.strftime("%a, %B %-d, %Y")
  end

end
