require_relative 'config/application'

# require APP_ROOT.join('app', 'models', 'tweet')
require APP_ROOT.join('app', 'controllers', 'controller')

Controller.run
