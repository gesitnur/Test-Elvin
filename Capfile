# frozen_string_literal: true

# # Load DSL and set up stages
# require 'capistrano/setup'

# # Include default deployment tasks
# require 'capistrano/deploy'

# # Load the SCM plugin appropriate to your project:
# require 'capistrano/scm/git'
# install_plugin Capistrano::SCM::Git

# require 'capistrano/puma'
# install_plugin Capistrano::Puma

# # Include tasks from other gems included in your Gemfile
# #
# # For documentation on these, see for example:
# #
# #   https://github.com/capistrano/rvm
# #   https://github.com/capistrano/bundler
# #   https://github.com/capistrano/rails
# #

# # require 'capistrano/rails'
# require 'capistrano/rbenv'
# require 'capistrano/rbenv_install'
# require 'capistrano/bundler'
# require 'capistrano/rails/console'
# # require "capistrano/rails/assets"
# require 'capistrano/rails/migrations'

# # Load custom tasks from `lib/capistrano/tasks` if you have any defined
# Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/scm/git'
require 'capistrano/rails/console'

install_plugin Capistrano::Puma
install_plugin Capistrano::SCM::Git
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
