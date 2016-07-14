## User Stories

As a User I should be able to:
- register in system
- login into system
- add new task
- edit task
- delete task
- share task (share using email of another user in the system who will be also able to manage task afterwards)
- see list of tasks (list should auto-update when someone shares tasks with user; in the list user should see who has shared task)

## Features

- Users, sign up / in / out
- Authentication so that a user can only access their own content
- CRUD for task
- Task sharing so many users would be able to manage their task

## Data 

**User**
_has_many : tasks_
 - email 
 - password
 
**Task**
_has_many : users_
 - title
 - description
 
## Pages 
  - Welcome Page (welcome#index)
  - Tasks Page (task#index)
 
 