require './config/environment'

use Rack::MethodOverride
use UsersController
use ItemsController
run ApplicationController