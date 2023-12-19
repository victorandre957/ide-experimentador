class ParameterValidator < ActiveModel::Validator
  def validate(record)
    puts record.parameter
    puts record.skill
    case record.skill
      when "navigation"
        if  !(record.parameter.has_key?("room")) or !(record.parameter.has_key?("waypoints"))
          record.errors.add :base, "Incorrect parameter formating"    

        elsif record.parameter.size != 2
          record.errors.add :base, "Wrong number of characteristics" 

        elsif record.parameter["waypoints"].size == 0
          record.errors.add :base, "Incorrect number of waypoints" 
        
        elsif record.parameter["waypoints"].any? { |waypoint| !waypoint.key?("x") || !waypoint.key?("y") || !waypoint.key?("z") || waypoint["x"].to_s.empty? || waypoint["y"].to_s.empty? || waypoint["z"].to_s.empty? }
          record.errors.add :base, "Incorrect number of waypoints" 
        end

      when "approach_robot", "authenticate_person", "approach_person", "wait_message", "send_message"
        if  !(record.parameter.has_key?("topic")) or record.parameter.size != 1
          record.errors.add :base, "Incorrect parameter formating"       
        end

      when "operate_drawer"   
        if  !(record.parameter.has_key?("action")) or record.parameter.size != 1
          record.errors.add :base, "Incorrect parameter formating"
        elsif record.parameter["action"] != "open" and record.parameter["action"] != "close"
          record.errors.add :base, "Incorrect action command"         
        end

      else
        record.errors.add :base, "This skill is evil"
    end
  end
end

class LocalPlanStep < ApplicationRecord
  belongs_to :robot
  validates :stepNumber, presence: true, numericality: true
  validates :label, presence: true, uniqueness: { scope: :robot_id }
  validates :skill, presence: true, inclusion: { in: %w(operate_drawer navigation authenticate_person approach_robot approach_person wait_message send_message),
    message: "%{value} is not a valid skill" }
  validates :parameter, presence: true
  validates_with ParameterValidator
end