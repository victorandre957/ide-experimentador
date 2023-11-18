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

  Scenario: Test deleting a plan as an authenticated user
    Given I have a method that receives a list of existing plans
    When an authenticated user tries to delete an existing execution plan
    Then the method should return a happy result

  Scenario: Test deleting a plan as a non-authenticated user
    Given I have a method that receives a list of existing plans
    When a non-authenticated user tries to delete an existing execution plan
    Then the method should return a sad result

Feature: Activate a local plan not currently executed

  As an user, I want to activate an already existing plan

  Scenario: Test activating a plan, not currently executed
    Given I have a method that activates a plan
    When the user selects a plan and it does exist, and is not being currently executed
    Then the method should return a happy result

  Scenario: Test activating a plan, currently executed
    Given I have a method that activates a plan
    When the user selects a plan and it does exist, and is being currently executed
    Then the method should return a sad result

Feature: Deactivate a local plan currently executed

  As an user, I want to deactivate a local plan, being executed

  Scenario: Test deactivating a valid plan, not currently executed
    Given I have a method that deactivates a plan
    When the user selects a plan and it does exist, and is not being currently executed
    Then the method should return a sad result

  Scenario: Test deactivating a valid plan, currently executed
    Given I have a method that deactivates a plan
    When the user selects a plan and it does exist, and is being currently executed
    Then the method should return a happy result