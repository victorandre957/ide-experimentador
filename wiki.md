# Project: ide-exeperimentador

## Group members

- Arthur Henrique - 211026673
- Artur Padoves - (Matrícula)
- Luiz Henrique - (Matrícula)
- Gustavo de Paula - (Matrícula)
- Thiago Carrijo - (Matrícula)
- Victor André - 211026664

## Project Scope

Create interface for a user to create local activity plans

## Scrum Master and Product Owner

- **Scrum Master:** [Scrum Master name]
- **Product Owner:** [Product Owner name]

## Features and Business Rules

### Create screen to create the activity plan

- Responsible: [Responsible name]
- Story Points: [ 1,  2,  3,  5,  8,  13]
- Description: The user should see a list of steps to be performed
and a list of steps selected for the plan.
- Business Rules: The user must select only the predefined steps, some steps may require others to
be executed first, if selected, the previous steps must be added as well

### Create screen to delete an existing plan

- Responsible: [Responsible name]
- Story Points: [ 1,  2,  3,  5,  8,  13]
- Description: The user should be able to select a plan for deletion.
- Business Rules: The user must be authenticated on the platform

### Other feature

- Responsible: [Responsible name]
- Story Points: [ 1,  2,  3,  5,  8,  13]
- Description: [Feature description]
- Business Rules: [Business rules]

## Branch Policy

- sprint-x: This Branch must have the code ready and revised for the sprint delivery
- feature: Created for the development of a new functionality
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
