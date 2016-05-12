# role :app, %w{5.101.116.131}
# role :web, %w{5.101.116.131}
# role :db,  %w{5.101.116.131}
role :app, %w{5.45.118.36}
role :web, %w{5.45.118.36}
role :db,  %w{5.45.118.36}

role :production_cron, %w{5.45.118.36}

set :stage, :production

set :log_level,   :info

set :ssh_options, {
    user: 'rails',
    forward_agent: true,
    port: 21212
}


set :application, 'demo.rees46.com'
set :deploy_to, "/home/rails/#{fetch(:application)}"
set :branch, 'master'
set :rails_env, 'production'


