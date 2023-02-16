class Team < ApplicationRecord
  def self.ransackable_associations(auth_object: nil)
    ["teachers", "students", "user"]
  end

  def self.ransackable_attributes(auth_object: nil)
    ["graduation"]
  end

  belongs_to :user
  has_many :students, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :schools, dependent: :destroy

  accepts_nested_attributes_for :students, allow_destroy: true
  accepts_nested_attributes_for :teachers, allow_destroy: true
  accepts_nested_attributes_for :schools, allow_destroy: true

  validates :graduation, presence: true
end
