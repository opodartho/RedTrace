require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/rails/console'

require 'capistrano/logrotate'

require 'capistrano/puma'
install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)
install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks
install_plugin Capistrano::Puma::Monit # if you need the monit tasks
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template
install_plugin Capistrano::Puma::Systemd  # if you use SystemD


require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
Dir.glob('lib/capistrano/**/*.rb').each { |r| import r }
