# The `ParameterValidator` class extends ActiveModel::Validator and includes modules
# for both public and private local plan step parameter validation in the Rails application.

class ParameterValidator < ActiveModel::Validator
  include LocalPlanStepPublic
  include LocalPlanStepPrivate
end

# The `LocalPlanStep` class represents a step in a local plan associated with a robot in the Rails application.
# It inherits from the `ApplicationRecord` class, serving as an ActiveRecord model.
class LocalPlanStep < ApplicationRecord
  # Associations
  belongs_to :robot

  # Validations
  validates :stepNumber, presence: true, numericality: true
  validates :label, presence: true, uniqueness: { scope: :robot_id }
  validates :skill, presence: true, inclusion: {
    in: %w(operate_drawer navigation authenticate_person approach_robot approach_person wait_message send_message),
    message: "%{value} is not a valid skill"
  }
  validates :parameter, presence: true

  # Custom validation using the `ParameterValidator` class
  validates_with ParameterValidator
end
