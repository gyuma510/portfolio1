class Student < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["student_name", "student_club"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["team", "user"]
  end

  belongs_to :user
  belongs_to :team

  validates :student_name, presence: true
end
