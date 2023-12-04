arraySkills = [
  "operate_drawer",
  "navigation",
  "authenticate_person",
  "approach_robot",
  "approach_person",
  "wait_message",
  "send_message"]

class ParameterValidator < ActiveModel::Validator
  def validate(record)
    puts record.parameter
    puts record.skill
    case record.skill
      when "navigation"
=begin
        "parameter":{
          "room":"PC Room 3",
          "waypoints": [
              {
                  "x":-27.23,
                  "y":18.0,
                  "z":-1.57
              },
              {
                  "x":-27.23,
                  "y":16.0
              },
              {
                  "x":-28.5,
                  "y":16.0
              },
              {
                  "x":-28.5,
                  "y":18.0,
                  "z":-1.57
              }
          ]
      },
=end
        if  !(record.parameter.has_key?("room")) or !(record.parameter.has_key?("waypoints"))
          record.errors.add :base, "Incorrect parameter formating"    

        elsif record.parameter.size != 2
          record.errors.add :base, "Wrong number of characteristics" 

        elsif record.parameter["waypoints"].size != 4
          record.errors.add :base, "Incorrect number of waypoints" 
        end

      when "approach_robot", "authenticate_person", "approach_person", "wait_message", "send_message"
=begin
        "parameter": [
          {"topic": "nurse"}
      ],
=end
        if  !(record.parameter.has_key?("topic")) or record.parameter.size != 1
          record.errors.add :base, "Incorrect parameter formating"       
        end

      when "operate_drawer"
=begin
                "parameter": [
                  {"action": "open"}
              ],
=end        
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

class LocalPlanStep < ApplicationRecord
  testArray = []
  #validates :robot_id, presence: true
  belongs_to :robot
  validates :stepNumber, presence: true, numericality: true
  validates :label, presence: true, uniqueness: { scope: :robot_id }
  validates :skill, presence: true, inclusion: { in: %w(operate_drawer navigation authenticate_person approach_robot approach_person wait_message send_message),
    message: "%{value} is not a valid skill" }
  validates :parameter, presence: true
  validates_with ParameterValidator
end