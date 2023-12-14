module LocalPlanStepPublic
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
