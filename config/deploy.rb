#
# bundle exec cap staging deploy:setup_config
# bundle exec cap staging deploy
#

lock '3.17.0'

set :application, 'redtrace'
set :repo_url, 'git@github.com:opodartho/RedTrace.git'
set :deploy_user, :deployer
set :deploy_path, '/app'
set :pty, true
set :tmp_dir, "/tmp"

set :rbenv_type, :system
set :rbenv_ruby, '3.1.0'
set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)

set :keep_releases, 3

set :bundle_binstubs, nil

set :linked_files do
  %W(config/application.yml config/database.yml config/credentials/#{fetch(:rails_env)}.key)
end

set(
  :linked_dirs,
  %w(log tmp/pids tmp/states tmp/sockets tmp/cache vendor/bundle public/system)
)

set(
  :config_files,
  %w(
    nginx.conf
    application.yml.template
    database.yml.template
    log_rotation
    puma.rb
    puma_init.sh
  )
)

set(:executable_config_files, %w(puma_init.sh))

set(
  :symlinks,
  [
    {
      source: 'nginx.conf',
      link: '/etc/nginx/sites-enabled/{{full_app_name}}.conf'
    },
    {
      source: 'puma_init.sh',
      link: '/etc/init.d/puma_{{full_app_name}}'
    },
    {
      source: 'log_rotation',
      link: '/etc/logrotate.d/{{full_app_name}}'
    }
  ]
)


namespace :deploy do
  before :deploy, 'deploy:check_revision'
  # before :deploy, "deploy:run_tests"
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  before 'deploy:setup_config', 'nginx:remove_default_vhost'
  after 'deploy:setup_config', 'nginx:reload'
  # after 'deploy:setup_config', 'monit:restart'
  after 'deploy:publishing', 'deploy:push_deploy_tag'
  after 'deploy:publishing', 'puma:restart'
end
