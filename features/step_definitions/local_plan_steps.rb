When /^fill in all the information$/ do
  fill_in 'labelInput', with: 'StepName'
  select 'Navegação', from: 'skillSelect'
  fill_in 'Sala', with 'RoomName'
  click_button 'Adicionar waypoint'
  fill_in 'x' with 1.3
  fill_in 'y' with 2.2
  fill_in 'z' with 3.1
end

When /^click "Confirm"$/ do
  click_button 'Save'
end
