# The `LocalPlanStepPrivate` module provides methods for validating navigation, common, and drawer parameters
# within the context of a local plan step in the Rails application.

module LocalPlanStepPrivate
  # Validates navigation parameters for a given record.
  # Expects the presence of "room" and "waypoints" keys in the parameter hash, with specified sizes.
  def validate(record)
    puts record.parameter
    puts record.skill
    case record.skill
      when "navigation"
        if  !(record.parameter.has_key?("room")) or !(record.parameter.has_key?("waypoints"))
          record.errors.add :base, "Incorrect parameter formating"    

        elsif record.parameter.size != 2
          record.errors.add :base, "Wrong number of characteristics" 

        elsif record.parameter["waypoints"].size != 4
          record.errors.add :base, "Incorrect number of waypoints" 
        end

      when "approach_robot", "authenticate_person", "approach_person", "wait_message", "send_message"
        if  !(record.parameter.has_key?("topic")) or record.parameter.size != 1
          record.errors.add :base, "Incorrect parameter formating"       
        end

      when "operate_drawer"   
        if  !(record.parameter.has_key?("action")) or record.parameter.size != 1
          record.errors.add :base, "Incorrect parameter formating"
        elsif record.parameter["action"] != "open" or record.parameter["action"] != "close"
          record.errors.add :base, "Incorrect action command"         
        end

      else
        record.errors.add :base, "This skill is evil"
    end
  end
end