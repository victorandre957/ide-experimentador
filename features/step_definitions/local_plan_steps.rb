Given /^that I am logged in$/ do
  # To-Do
end

And /^there is a robot with id = "([^"]*)"$/ do |robot_id|
  r = Robot.create!(id: robot_id)
end

And /^I am creating a local plan for the robot "([^"]*)"$/ do |page|
  visit "local_plan_steps/#{page}"
end

And /^fill in all the information$/ do
  fill_in 'labelInput', with: 'StepName'
  select 'Navegação', from: 'skillSelect'
  fill_in 'Sala', with: 'RoomName'
  click_button 'Adicionar waypoint'
  fill_in 'x', with: 1.3
  fill_in 'y', with: 2.2
  fill_in 'z', with: 3.1
end

And /^click "Confirm"$/ do
  click_button 'Save'
end

Then /^there should be LocalPlanSteps with robot_id: "([^"]*)"$/ do |robot_id|
  LocalPlanStep.count(robot_id: robot_id).should be > 0
end