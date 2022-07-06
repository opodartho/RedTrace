#
# bundle exec cap production deploy:setup_config
# bundle exec cap production puma:config
# bundle exec cap production puma:nginx_config
# bundle exec cap production logrotate:config
# bundle exec cap production puma:systemd:config
# bundle exec cap production puma:systemd:enable
# bundle exec cap production deploy
#

lock '3.17.0'

set :application, 'redtrace'
set :repo_url, 'git@github.com:opodartho/RedTrace.git'
set :user, :deployer
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
    application.yml.template
    database.yml.template
  )
)



namespace :deploy do
  before 'deploy:setup_config', 'nginx:remove_default_vhost'
  after 'deploy:setup_config', 'nginx:reload'

  # before :deploy, 'deploy:check_revision'
  before 'deploy:check:linked_files', 'deploy:check:upload_env_key'
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:push_deploy_tag'
  # after 'deploy:publishing', 'puma:restart'
end

