
Feature: Delete an existing local plan

  As a user, I want to be able to delete an existing execution plan
  @javascript
  Scenario: Test deleting an existing execution plan and verifying successful deletion
    Given there is a method capable of deleting an existing execution plan
    And an execution plan exists in a robot with id "999"
    When the user informs the to-be deleted plan
    Then the method should successfully delete the plan in the robot with id "999"
  @javascript
  Scenario: Test deleting a non-existing execution plan
    Given there is a method capable of deleting a specific execution plan
    And the user attempts accesses the plans under a robot with id "777"
    When the non-existing plan is specified for deletion
    Then the method shouldn't do anything
  @javascript
  Scenario: Test accessing a deleted plan
    Given that I am logged in
    And I have successfully deleted an existing local plan
    Then the deleted local plan should not appear on screen
  @javascript
  Scenario: Test cancelling the deletion process before deleting
    Given that I am logged in
    And there's an experiment with a robot with a local plan, robot_id "999"
    And I'm on the "delete local plan" screen, for a robot with id "999"
    When I change the plan or I select a "Cancel" option
    Then the local plan should not be deleted

  
