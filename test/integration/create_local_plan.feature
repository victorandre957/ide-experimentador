Feature: Create a new local plan

  As a user, I want to be able to create a new execution plan

  Scenario: Test creating a new valid plan
    Given I have method that receives a sequence of activities selected for the plan as a parameter
    When the user selects a possible sequence (ex: [open box, get item from box, close box, deliver item])
    Then the method must return a happy result

  Scenario: Test creating a new invalid plan
    Given I have method that receives a sequence of activities selected for the plan as a parameter
    When the user selects a sequence with missing steps (ex: [open box, close box, deliver item])
    Then the method must return a sad result

  Scenario: Test creating a new plan with null values
    Given I have method that receives a sequence of activities selected for the plan as a parameter
    When the user did not select any step for the sequence (ex: [])
    Then the method must return a sad result

  Scenario: Test creating a new plan with non-existent values
    Given I have method that receives a sequence of activities selected for the plan as a parameter
    When the user selected an option that does not exist (ex: [open box, start flying])
    Then the method must return a sad result