

Feature: Update an existing local plan

  As a user, I want to be able to update an existing local plan
  @javascript
  Scenario: I should be able to change an existing step parameter
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change a step parameters
    And click "Confirm"
    Then the local plan should have updated parameters for the step
  @javascript
  Scenario: I should be able to change an existing step skill
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change a step skill and parameters
    And click "Confirm"
    Then the local plan should have updated skill and parameters for the step
  @javascript
  Scenario: The update may be cancelled without updating the plan
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "editing local plan"
    When I change the plan
    And click "Cancel"
    Then the local plan should not be changed
  @javascript  
  Scenario: Updating a existing valid plan using invalid parameters
    Given that I am logged in
    And there's an experiment with a robot
    And I'm on the "editing robot"
    When I click “Update a local plan”
    And update a parameter 
    And click "Update"
    Then an error message should appear
