# checks for app environment details
require './config/environment'

# allows for use of patch, delet
use Rack::MethodOverride

# lets app know to look for processes in UsersController/ItemsController
use UsersController
use ItemsController

# lets app know ApplicationController is the master model
run ApplicationController