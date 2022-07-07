set :stage, :production
set :branch, 'feature/capistrano-deployment'

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
server '119.8.186.24', user: fetch(:user).to_s, roles: %w[web app db], primary: true

set :deploy_to, "#{fetch(:deploy_path)}/#{fetch(:full_app_name)}"

set :rails_env, :production

# --------- Default Puma Configurable options -------------------------

# set :puma_user, fetch(:user)
# set :puma_nginx, :web
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
# set :puma_control_app, false
# set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/config/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_access.log"
# set :puma_error_log, "#{shared_path}/log/puma_error.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [1, 4]
set :puma_workers, 4
# set :puma_worker_timeout, nil
# set :puma_init_active_record, false
# set :puma_preload_app, false
# set :puma_daemonize, false
# set :puma_plugins, []  #accept array of plugins
# set :puma_tag, fetch(:application)
# set :puma_restart_command, 'bundle exec puma'
# set :puma_service_unit_name, "puma_#{fetch(:application)}_#{fetch(:stage)}"
# set :puma_systemctl_user, :system # accepts :user
# set :puma_enable_lingering, fetch(:puma_systemctl_user) != :system # https://wiki.archlinux.org/index.php/systemd/User#Automatic_start-up_of_systemd_user_instances
# set :puma_lingering_user, fetch(:user)
# set :puma_service_unit_env_file, nil
# set :puma_service_unit_env_vars, []
# set :puma_phased_restart, false
set :puma_service_unit_env_vars, %w[
  RBENV_ROOT=/usr/local/rbenv
  RBENV_VERSION=3.1.0
]


# ------- Deafult nginx configurable options --------------
#
# set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
# set :nginx_flags, 'fail_timeout=0'
# set :nginx_http_flags, fetch(:nginx_flags)
set :nginx_server_name, 'redtrace.xyz *.redtrace.xyz'
# set :nginx_sites_available_path, '/etc/nginx/sites-available'
# set :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
# set :nginx_socket_flags, fetch(:nginx_flags)
set :nginx_ssl_certificate, "/etc/letsencrypt/live/redtrace.xyz/fullchain.pem"
set :nginx_ssl_certificate_key, "/etc/letsencrypt/live/redtrace.xyz/privkey.pem"
set :nginx_use_ssl, true
# set :nginx_use_http2, true
# set :nginx_downstream_uses_ssl, false


# ------- Default logrotate configurable options ---------------

# set :logrotate_role, :app
# set :logrotate_conf_path, -> { File.join('/etc', 'logrotate.d', "#{fetch(:application)}_#{fetch(:stage)}") }
# set :logrotate_log_path, -> { File.join(shared_path, 'log') }
# set :logrotate_logs_keep, -> { 12 }
# set :logrotate_interval, -> { 'daily' }
# set :logrotate_user, -> { fetch(:user) }
# set :logrotate_group, -> { fetch(:user) }
# set :logrotate_template_path, -> { :default }
