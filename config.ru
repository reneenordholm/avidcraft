require './config/environment'

# allows for use of patch, delet
use Rack::MethodOverride

use UsersController
use ItemsController
run ApplicationController