# The `LocalPlanStepPrivate` module provides methods for validating navigation, common, and drawer parameters
# within the context of a local plan step in the Rails application.

module LocalPlanStepPrivate
  # Validates navigation parameters for a given record.
  # Expects the presence of "room" and "waypoints" keys in the parameter hash, with specified sizes.
  def validate_navigation(record)
    validate_parameter(record, %w(room waypoints), [2, 4])
  end

  # Validates common parameters for a given record.
  # Expects the presence of a "topic" key in the parameter hash, with a specified size.
  def validate_common(record)
    validate_parameter(record, ["topic"], [1])
  end

  # Validates drawer parameters for a given record.
  # Expects the presence of an "action" key in the parameter hash, with a specified size.
  # Additionally, checks if the action command is either "open" or "close".
  def validate_drawer(record)
    validate_parameter(record, ["action"], [1])
    valid_actions = %w(open close)
    record.errors.add(:base, "Incorrect action command") unless valid_actions.include?(record.parameter["action"])
  end

  # Generic method for validating parameters based on provided keys and sizes.
  # Adds errors to the record if the parameter formatting or characteristics are incorrect.
  def validate_parameter(record, keys, sizes)
    keys.each_with_index do |key, index|
      unless record.parameter.has_key?(key) && record.parameter.size == sizes[index]
        record.errors.add :base, "Incorrect parameter formatting or characteristics"
        break
      end
    end
  end
end
