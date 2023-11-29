

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

  Scenario: Updating a existing valid plan with valid parameter
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Update a local plan”
    And update a parameter
    And click "Update"
    Then I should be redirected to the "edit robot" page
    And there should be the text "Edit local plan"
    
  Scenario: Updating a existing valid plan whit invalid parameter
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Update a local plan”
    And update a parameter
    And click "Update"
    And the parameters are invalid
    
  Scenario: Updating a existing valid plan whit valid parameter for another that invalid
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Update a local plan”
    And update a parameter 
    And click "Update"
    And the new parameters are invalid
