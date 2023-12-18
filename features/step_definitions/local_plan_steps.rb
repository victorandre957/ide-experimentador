Given /^that I am logged in$/ do
  # Simulating logged-in state
  # To-Do
end

And /^there is a robot with id = "([^"]*)"$/ do |robot_id|
  Robot.create!(id: robot_id)
end

And /^I am creating a local plan for the robot "([^"]*)"$/ do |page|
  visit "local_plan_steps/#{page}"
end

And /^fill in all the information$/ do
  click_button 'Adicionar Passo'
  fill_in_information
end

And /^click "Confirm"$/ do
  click_button 'Salvar'
end

Then /^there should be LocalPlanSteps with robot_id: "([^"]*)"$/ do |robot_id|
  assert LocalPlanStep.where(robot_id: robot_id).count > 0
end

private

def fill_in_information()
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
