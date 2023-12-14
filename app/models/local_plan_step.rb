class ParameterValidator < ActiveModel::Validator
  def validate(record)
    case record.skill
    when "navigation"
      validate_navigation(record)
    when "approach_robot", "authenticate_person", "approach_person", "wait_message", "send_message"
      validate_common(record)
    when "operate_drawer"
      validate_drawer(record)
    else
      record.errors.add :base, "This skill is invalid"
    end
  end

  private

  def validate_navigation(record)
    validate_parameter(record, %w(room waypoints), [2, 4])
  end

  def validate_common(record)
    validate_parameter(record, ["topic"], [1])
  end

  def validate_drawer(record)
    validate_parameter(record, ["action"], [1])
    valid_actions = %w(open close)
    record.errors.add(:base, "Incorrect action command") unless valid_actions.include?(record.parameter["action"])
  end

  def validate_parameter(record, keys, sizes)
    keys.each_with_index do |key, index|
      unless record.parameter.has_key?(key) && record.parameter.size == sizes[index]
        record.errors.add :base, "Incorrect parameter formatting or characteristics"
        break
      end
    end
  end
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
