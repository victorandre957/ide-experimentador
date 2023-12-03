arraySkills = [
  "operate_drawer",
  "navigation",
  "authenticate_person",
  "approach_robot",
  "approach_person",
  "wait_message",
  "send_message",
  "navigation"]

#class parameterValidator < ActiveRecord::Validator 
 # def validadeParameter(skill)
  # case skill
  #  when operate_drawer
  #    
 #   when navigation
#
 #   when authenticate_person
#
#    when approach_robot
#
#    when approach_person
#
#   when wait_message
#
#   when send_message
#
  #  when navigation
  #    
 #   else
#      skill.errors.add :base, "This skill is evil"
#    end
#  end
#end

class parameterValidator < ActiveRecord::Validator
end

class parameterValidator < ActiveRecord::Validator 
end

class LocalPlanStep < ApplicationRecord
  #validates :robot_id, presence: true
  belongs_to :robot
  validates :stepNumber, presence: true, uniqueness: true, numericality: true
  validates :label, presence: true,  uniqueness: true
  validates :skill, presence: true, inclusion: { in: %w(operate_drawer navigation authenticate_person approach_robot approach_person wait_message send_message navigation),
    message: "%{value} is not a valid skill" }
  validates :parameters, presence: true
  #validates :parameter if :skill 
  #validates :parameter if :skill 
  #validates :parameter if :skill 
end