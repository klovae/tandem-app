class Section < ApplicationRecord
  belongs_to :project
  has_many :tasks

  validates :name, presence: true

end
