#Implementing the steps in create_local_plan.features
# Scenario: Test creating a new valid plan
Given /^that I am logged in/ do
  # Simulating logged-in state
  # To-Do
end

And /^there is a robot with id = "([^"]*)"$/ do |robot_id|
  Robot.create!(id: robot_id)
end

And /^I am creating a local plan for the robot "999"/ do
  visit "local_plan_steps/999"
end

And /^fill in all the information$/ do
  fill_in_information
end

And /^click "Confirm"/ do
  click_button 'Salvar Plano Local'
end

Then /^there should be LocalPlanSteps with robot_id: "([^"]*)"$/ do |robot_id|
  assert LocalPlanStep.where(robot_id: robot_id).count > 0
end
##

And /^don't fill in all the information for the robot/ do
  fill_in_incomplete
end

Then /^there shouldn't be LocalPlanSteps with robot_id: "([^"]*)"$/ do |robot_id|
  assert LocalPlanStep.where(robot_id: robot_id).count == 0
end
##

And /^there's an experiment with a robot, with id = "([^"]*)"$/ do |robot_id|
  Robot.create!(id: robot_id)
end

And /^I am on the "editing robot" page for a robot with id "([^"]*)"$/ do |robot_id|
  visit "local_plan_steps/#{robot_id}"
end

And /^click "Cancel"/ do
  click_button 'Deletar passo'
end

When /^I click “Create a local plan”/ do
 click_button 'Adicionar Novo Passo'
end
###

Given /^there is a method capable of deleting an existing execution plan/ do
  assert delete_local_plan.defined? == true
end

And /^an execution plan exists in a robot with id "([^"]*)"$/ do |robot_id|
  Robot.create!(id: robot_id)
  visit "local_plan_steps/#{robot_id}"
  fill_in_information
  click_button 'Salvar Plano Local'
  assert LocalPlanStep.where(robot_id: robot_id).count > 0
end

When /^the user informs the to-be deleted plan for the robot with id "999"/ do
  click_button 'Deletar Plano Local'
end

Then /^the method should successfully delete the plan/ do      ##########
  assert LocalPlanStep.where(robot_id: robot_id).count == 0
end

##

And /^the user attempts accesses the plans under a robot with id "([^"]*)"$/ do
  Robot.create!(id: robot_id)
  visit "local_plan_steps/#{robot_id}"
end

When /^the non-existing plan is specified for deletion/ do
  click 'Deletar Plano'
end

Then /^the method shouldn't do anything/ do
  assert LocalPlanStep.where(robot_id: 777).count == 0
end

##
And /^I have successfully deleted an existing local plan/ do
  #creates a new robot and local plan
  Robot.create!(id: 999)
  beginning_value = LocalPlanStep.where(robot_id: 999)
  visit "local_plan_steps/#{999}"
  fill_in_information
  click_button 'Adicionar Novo Passo'

  #Deletes the new local plan
  click 'Deletar Plano'
  end_value = LocalPlanStep.where(robot_id: robot_id).count

  #asserts that the local plan was deleted
  assert end_value == beginning_value
end

Then /^the deleted local plan should not appear on screen/ do
  #
end

private

def fill_in_incomplete_coords
  fill_in 'labelInput', with: 'StepName'
  select 'Navegação', from: 'skillSelect'
  fill_in 'Sala', with: 'RoomName'
  click_button 'Adicionar waypoint'
  fill_in_coordinates(1.3, null, 3.1)
end

def fill_in_incomplete
  fill_in 'labelInput', with: 'StepName'
  select 'Navegação', from: 'skillSelect'
  fill_in 'Sala', with: 'RoomName'
end

def fill_in_information
  fill_in 'labelInput', with: 'StepName'
  select 'Navegação', from: 'skillSelect'
  fill_in 'Sala', with: 'RoomName'
  click_button 'Adicionar waypoint'
  fill_in_coordinates(1.3, 2.2, 3.1)
end

def fill_in_coordinates(x, y, z)
  fill_in 'x', with: x
  fill_in 'y', with: y
  fill_in 'z', with: z
end
