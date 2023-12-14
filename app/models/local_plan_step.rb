class ParameterValidator < ActiveModel::Validator
  include LocalPlanStepPublic
  include LocalPlanStepPrivate

end

class LocalPlanStep < ApplicationRecord
  belongs_to :robot
  validates :stepNumber, presence: true, numericality: true
  validates :label, presence: true, uniqueness: { scope: :robot_id }
  validates :skill, presence: true, inclusion: {
    in: %w(operate_drawer navigation authenticate_person approach_robot approach_person wait_message send_message),
    message: "%{value} is not a valid skill"
  }
  validates :parameter, presence: true
  validates_with ParameterValidator
end
