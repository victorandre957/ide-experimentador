module LocalPlanStepPrivate
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
