# Project: ide-exeperimentador

## Group members

- Arthur Henrique - 211026673
- Artur Padovesi - 211038208
- Luiz Henrique - 211068403
- Gustavo de Paula - 212006871
- Thiago Carrijo - 211068350
- Victor André - 211026664

## Project Scope

Create interface for a user to create local activity plans

## Scrum Master and Product Owner

- **Scrum Master:** Victor André
- **Product Owner:** Artur Padovesi

## Features and Business Rules

### Create screen to create the activity plan

- Responsible: Victor André and Thiago Carrijo
- Story Points: 5
- Description: The user should be able to create a list of steps to be performed.
- Business Rules:
    1. The user must be authenticated on the platform.
    2. Step may only use skills the robot has. Otherwise alert the user.
    3. Skills offered are the ones the [experimenter](https://github.com/VicenteMoraes/robotics_sim) recognizes. It seems they are [here](https://github.com/VicenteMoraes/skill_library)

### Create screen to delete an existing plan

- Responsible: Victor André and Thiago Carrijo
- Story Points: 1
- Description: The user should be able to select a plan for deletion.
- Business Rules: The user must be authenticated on the platform

### Create screen to update an existing plan

- Responsible: Victor André and Thiago Carrijo
- Story Points: 1
- Description: The user should be able to select a plan for update.
- Business Rules: The user must be authenticated on the platform

### Create Controller to create the activity plan

- Responsible: Artur Padovesi and Gustavo de Paula
- Story Points: 2
- description: API functions that allow create plans
- Business Rules: The user must be authenticated on the platform

### Create Controller to delete the activity plan

- Responsible: Artur Padovesi and Gustavo de Paula
- Story Points: 2
- description: API functions that allow deleting created plans
- Business Rules: The user must be authenticated on the platform

### Create Controller to update the activity plan

- Responsible: Artur Padovesi and Gustavo de Paula
- Story Points: 2
- description: API functions that allow update created plans
- Business Rules: The user must be authenticated on the platform

### Create Cucumber tests to create the activity plan

- Responsible: Arthur Henrique and Luiz Henrique
- Story Points: 2
- description: creates tests to ensure everything is correct

### Create Cucumber tests to delete the activity plan

- Responsible: Arthur Henrique and Luiz Henrique
- Story Points: 2
- description: creates tests to ensure everything is correct

### Create Cucumber tests to update the activity plan

- Responsible: Arthur Henrique and Luiz Henrique
- Story Points: 2
- description: creates tests to ensure everything is correct,

## ABC Score (method complexity < 20)

- Responsible: Victor André

|              File                    |     After Refactor     |    Before Refactor     |
|--------------------------------------|-------------------------------------------------|
| local_plan_steps_controller.rb       | 8.6 complexity/method  | 7.4 complexity/method  |
| local_plan_step.rb                   | 82.0 complexity/method | 6.7 complexity/method  |
| local_plan_steps.rb                  | N/A complexity/method  | 13.2 complexity/method |
| local_plan_steps_controller_spec.rb  | N/A complexity/method  | 19.1 complexity/method |
| local_plan_steps_controller_test.rb  | N/A complexity/method  |  4.9 complexity/method |

## Branch Policy

- sprint-x: This Branch must have the code ready and revised for the sprint delivery
- feature: Created for the development of a new functionality
- refactor: Created to improve specific operation without altering functionality
- bug: Created to correct errors and failures
- docs: Created for documentation

## Commit Policy

- "scope (type): subject"

### Scopes

- Part of code that is undergoing modifications
- may be null if the commit makes changes to several files (should be avoided)

### Types

- feat: A new feature
- fix: A bug fix
- docs: Documentation related changes
- refactor: A code that neither fix bug nor adds a feature
- test: Adding new test or making changes to existing test
- style: A code that is related to styling
- wip: Use when work is in progress and you are aware that it will not be completed soon

### Subjects

- Write your commit messages in the imperative: "Fix bug" not "Fixed bug" or "Fixes bug."
