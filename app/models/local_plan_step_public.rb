# The `LocalPlanStepPublic` module provides a method for validating parameters based on the specified skill
# within the context of a local plan step in the Rails application.

module LocalPlanStepPublic
  # Validates parameters for a given record based on its skill.
  # Dispatches validation to specific methods based on the skill type.
  # Supported skills include "navigation," "approach_robot," "authenticate_person," "approach_person," "wait_message," "send_message," and "operate_drawer."
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
end
