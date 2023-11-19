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

- **Scrum Master:** [Scrum Master name]
- **Product Owner:** [Product Owner name]

## Features and Business Rules

### Create screen to create the activity plan

- Responsible: Artur Padovesi and Arthur Henrique
- Story Points: 5
- Description: The user should be able to create a list of steps to be performed.
- Business Rules:
    1. The user must be authenticated on the platform.
    2. Step may only use skills the robot has. Otherwise alert the user.
    3. Skills offered are the ones the [experimenter](https://github.com/VicenteMoraes/robotics_sim) recognizes

### Create screen to delete an existing plan

- Responsible: Luiz Henrique and Gustavo de Paula
- Story Points: 1
- Description: The user should be able to select a plan for deletion.
- Business Rules: The user must be authenticated on the platform

### Create screen to update an existing plan

- Responsible: Thiago Carrijo and Victor André
- Story Points: 1
- Description: The user should be able to select a plan for update.
- Business Rules: The user must be authenticated on the platform

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
