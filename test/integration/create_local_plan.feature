Feature: Create a new local plan

  As a user, I want to be able to create a new execution plan

  Scenario: Test creating a new valid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Create a local plan”
    And fill in all the information
    And click "Confirm"
    Then I should be redirected to the "edit robot" page
    And there should be the text "Edit local plan"

  Scenario: Test creating a new invalid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Create a local plan”
    And don't fill in all the information
    And click "Confirm"
    Then an error message should be displayed due to missing informationt

  Scenario: Test creating a new invalid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Create a local plan”
    And fill in all the information but add a skill that doesn't exist
    And click "Confirm"
    Then an error message should be displayed due to the non-existent skill


Feature: Delete an existing local plan

  As a user, I want to be able to delete an existing execution plan

  Scenario: Test deleting an existing execution plan
    Given I have a method that deletes a specific existing execution plan
    When the user informs the to-be deleted plan and it does exist
    Then the method should return a happy result

  Scenario: Test deleting a non-existing execution plan
    Given I have a method that deletes a specific existing execution plan
    When the user informs the to-be deleted plan and it does not exist
    Then the method should return a sad result
  # divisão
  Scenario: Test deleting a plan as an authenticated user
    Given I have a method that receives a list of existing plans
    When an authenticated user tries to delete an existing execution plan
    Then the method should return a happy result

  Scenario: Test deleting a plan as a non-authenticated user
    Given I have a method that receives a list of existing plans
    When a non-authenticated user tries to delete an existing execution plan
    Then the method should return a sad result


Feature: Update an existing local plan

  As a user, I want to be able to update an existing local plan

  Scenario: I should be able to change an existing step parameters
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change a step parameters
    And click on "Confirm"
    Then the local plan should have updated parameters for the step

  Scenario: I should be able to change an existing step skill
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change a step skill and parameters
    And click on "Confirm"
    Then the local plan should have updated skill and parameters for the step

  Scenario: The update may be cancelled without updating the plan
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change the plan
    And click on "Cancel"
    Then the local plan should not be changed

  # divisão:
    Given I have a method that update a specific existing parameter
    When the user informs that to be updated parameter and it does exist
    Then the method should return a happy result
    
    Given I have a method that update a specific existing parameter
    When the user informs that to be updated parameter and it does not exist
    Then the method should return a sad result
    
    Given I have a method that update a specific existing parameter
    When the user informs a parameter to be updated that exists for another that does not exist
    Then the method should return a sad result
    
    Given I have a method that update a specific existing parameter
    When the user informs that to be updated parameter without selecting the skill
    Then the method should return a sad result
