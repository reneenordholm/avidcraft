# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app&nbsp;&nbsp;
        --> Sinatra provides the framework for faster web application creation in Ruby. By requiring and installing the Sinatra gem in the Gemfile, and having the root controller inherit from the Sinatra base, an application has the initial framework and capabilities availble for building an app that utilizes all the features Sinatra has to offer.
- [X] Use ActiveRecord for storing information in a database&nbsp;&nbsp;
        --> ActiveRecord is a great management tool that acts as the "middleperson" between the application and the database. Setting up ActiveRecord in the app takes four steps-- 1. Requiring 'activerecord' and 'sinatra-activerecord' in the gemfile and running bundle install in the terminal to install the gem. 2. Letting ActiveRecord know what database language the app uses, in this AVIDcraft we are using SQL via the SQLite3 gem. 3. Setting up the connection to our database within our environment.rb file. 4. Setting the models within the app to inherit from ActiveRecord.
- [X] Include more than one model class (e.g. User, Post, Category)&nbsp;&nbsp;
        --> AVIDcraft utilizes two models: the User class and an Item class.
- [X] Include at least one has_many relationship on your User model (e.g. User  
has_many Posts)&nbsp;&nbsp;
        --> The User class has_many items.
- [X] Include at least one belongs_to relationship on another model (e.g. Post 
belongs_to User)&nbsp;&nbsp;
        --> The Item class belongs_to the User class.
- [X] Include user accounts with unique login attribute (username or email)&nbsp;&nbsp;
        --> Validations in the User model are set to only allow unique usernames to register.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying&nbsp;&nbsp;
        --> The ItemsController utilizes CRUD.
- [X] Ensure that users can't modify content created by other users&nbsp;&nbsp;
        --> Being that AVIDcraft utilizes sessions, when user creates an item, the item is saved to the database as belonging to the user who created it.  When a logged in user clicks on an item they wish to edit, the update method in the ItemsController verifies that the user making the request is the same user who initially created the item. If  this is not a match the user is not allowed to edit the item. 
- [X] Include user input validations&nbsp;&nbsp;
        --> Validations in the User model are setup for the username (can't be blank, must be unique, must be at least 4 characters, cannot contain blank space numbers, special characters), email (can't be blank, must be in format xxxx@xxxx.xxx), and password (can't be blank, must be betweem 6-20 characters).
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)&nbsp;&nbsp;
        --> User error messages are shown when login and signup failures arise.
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code&nbsp;&nbsp;
        --> README.md specifications met.

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message