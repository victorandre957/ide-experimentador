Feature: Create a new local plan

  As a user, I want to be able to create a new execution plan
  @javascript
  Scenario: Test creating a new valid plan
    Given that I am logged in
    And there is a robot with id = "999"
    And I am creating a local plan for the robot "999"
    And fill in all the information
    And click "Confirm"
    Then there should be LocalPlanSteps with robot_id: "999"
  @javascript
  Scenario: Test creating a new invalid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I am on the "editing robot"
    When I click “Create a local plan”
    And don't fill in all the information
    And click "Confirm"
    Then an error message should be displayed due to missing information
  @javascript
  Scenario: Test creating a new invalid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I am on the "editing robot"
    When I click “Create a local plan”
    And fill in all the information but add a skill that doesn't exist
    And click "Confirm"
    Then an error message should be displayed due to the non-existent skill
  @javascript
  Scenario: Test creating a new valid plan as a non-authenticated user
    Given that I am not logged in
    And there's an experiment with a robot
    And I am on the "editing robot"
    When I click "Create a local plan"
    And fill in all the information
    And click "Confirm"
    Then an error message should be displayed due to the user not being authenticated
  @javascript
  Scenario: Test cancelling the creation of a new valid plan
    Given that I am logged in
    And there's an experiment with a robot
    And I am on the "editing robot"
    When I click “Create a local plan”
    And fill in all the information
    And click "Cancel"
    Then I should be redirected to the "initial" page
    And there should be the text "Local plan's edition cancelled"

