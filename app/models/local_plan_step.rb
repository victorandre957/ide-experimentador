class LocalPlanStep < ApplicationRecord
  belongs_to :robot
  validates :label, presence: true
end
