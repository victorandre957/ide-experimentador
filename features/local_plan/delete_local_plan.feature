
Feature: Delete an existing local plan

  As a user, I want to be able to delete an existing execution plan
  @javascript
  Scenario: Test deleting an existing execution plan and verifying successful deletion
    Given there is a method capable of deleting an existing execution plan
    And an execution plan exists in the system
    When the user informs the to-be deleted plan
    And the specified plan exists
    Then the method should successfully delete the plan
  @javascript
  Scenario: Test deleting a non-existing execution plan
    Given there is a method capable of deleting a specific execution plan
    And the user attempts to delete a plan that does not exist
    When the non-existing plan is specified for deletion
    Then the method should return an unsuccessful result
  @javascript
  Scenario: Test deleting a plan as an authenticated user
    Given there is a method that retrieves a list of existing plans
    And the user is authenticated
    When an authenticated user tries to delete an existing execution plan
    Then the method should successfully delete the plan
  @javascript
  Scenario: Test deleting a plan as a non-authenticated user
    Given there is a method that retrieves a list of existing plans
    And the user is not authenticated
    When a non-authenticated user tries to delete an existing execution plan
    Then the method should return an unauthorized
  @javascript
  Scenario: Test accessing a deleted plan
    Given that I am logged in
    And I have successfully deleted an existing local plan
    And I'm on the "delete local plan" screen
    Then the deleted local plan should not appear on screen
  @javascript
  Scenario: Test cancelling the deletion process before deleting
    Given that I am logged in
    And there's an experiment with a robot with a local plan
    And I'm on the "delete local plan" screen
    When I change the plan or I select a "Cancel" option
    And click on "Confirm"
    Then the local plan should not be deleted
