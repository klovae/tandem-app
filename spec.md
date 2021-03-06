# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship - Project has_many Tasks 
- [x] Include at least one belongs_to relationship - Task belongs_to Project
- [x] Include at least two has_many through relationships - 1) User has_many Projects through Permissions, 2) User has_many Tasks through Assignments
- [x] Include at least one many-to-many relationship - User has many Projects through Permissions, Project has_many Users through Permissions.
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user - Permissions has an "access_level" string that determines how a user may interact with a project.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature - All tasks assigned to logged-in user: /mytasks
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (OmniAuth for Facebook)
- [x] Include nested resource show or index - /projects/:id/permissions
- [x] Include nested resource "new" form - /projects/:id/tasks/new
- [x] Include form display of validation errors - /users/new

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate