# role :app, %w{5.101.116.131}
# role :web, %w{5.101.116.131}
# role :db,  %w{5.101.116.131}
role :app, %w(176.9.145.71)
role :web, %w(176.9.145.71)
role :db,  %w(176.9.145.71)

role :production_cron, %w(176.9.145.71)

set :stage, :production

set :log_level, :info

set :ssh_options,     user: 'rails',
                      forward_agent: true,
                      port: 21_212

set :application, 'demo.rees46.com'
set :deploy_to, "/home/rails/#{fetch(:application)}"
set :branch, 'master'
set :rails_env, 'production'
