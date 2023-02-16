class Teacher < ApplicationRecord
  def self.ransackable_attributes(auth_object: nil)
    ["teacher_name"]
  end

  def self.ransackable_associations(auth_object: nil)
    ["team", "user"]
  end

  belongs_to :user
  belongs_to :team

  validates :teacher_name, presence: true
end
