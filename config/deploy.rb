lock '3.4.0'

set :application, 'demo.rees46.com'

set :repo_url, 'git@github.com:rees46/rees46_demoshop.git'
set :scm, :git

set :deploy_to, "/home/rails/#{fetch(:application)}"
set :deploy_via,      :remote_cache
set :ssh_options,     forward_agent: true
set :use_sudo,        false
set :keep_releases, 5
set :linked_files, %w(config/database.yml config/secrets.yml config/unicorn.rb)
set :linked_dirs, %w(public/system public/uploads public/files log pids sockets vendor/bundle)

set :normalize_asset_timestamps, false

set :rails_env, 'production'
set :default_stage, 'production'

set :keep_releases, 10

set :rvm_type, :user
# set :rvm_custom_path, '~/.rvm'  # only needed if not detected
set :rvm_ruby_string, '2.3.0'

# Whenever
# set :whenever_roles, "#{fetch(:rails_env)}_cron"
# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
# set :whenever_command, '~/.rvm/bin/rvm default do bundle exec whenever'
# require 'whenever/capistrano'

# Sidekiq
# set :sidekiq_env, 'production'
# set :sidekiq_options, '-C config/sidekiq.yml'
# set :sidekiq_timeout, 300

# Only precompile assets when necessary [config]
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
Rake::Task['deploy:assets:precompile'].clear_actions
class PrecompileRequired < StandardError; end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Start unicorn'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path}; ~/.rvm/bin/rvm default do bundle exec unicorn -c config/unicorn.rb -E #{fetch :rails_env} -D"
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
    end
  end

  desc 'Create database'
  # task :database, :roles => :db, :only => { :primary => true } do
  #   run "cd #{current_path}; bundle exec rake db:create RAILS_ENV=#{rails_env}"
  # end

  desc 'Seed database'
  task :seed do
    on roles(:db), in: :sequence, wait: 5 do
      run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
  end

  # [:reset, :setup].each do |name|
  #   task name do
  #     p "Access denied!"
  #   end
  # end

  # namespace :assets do
  #   task :precompile do
  #     on roles(:db), in: :sequence, wait: 5 do
  #       from = source.next_revision(current_revision)
  #       if releases.length <= 1 || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
  #       else
  #         logger.info "Skipping asset pre-compilation because there were no asset changes"
  #       end
  #     end
  #   end
  # end

  namespace :assets do
    desc 'Precompile assets'
    task :precompile do
      on roles(fetch(:assets_roles)) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            begin
              # find the most recent release
              latest_release = capture(:ls, '-xr', releases_path).split[1]

              # precompile if this is the first deploy
              fail PrecompileRequired unless latest_release

              latest_release_path = releases_path.join(latest_release)

              # precompile if the previous deploy failed to finish precompiling
              begin
                execute(:ls, latest_release_path.join('assets_manifest_backup'))
              rescue
                raise(PrecompileRequired)
              end

              fetch(:assets_dependencies).each do |dep|
                # execute raises if there is a diff
                begin
                  execute(:diff, '-Naur', release_path.join(dep), latest_release_path.join(dep))
                rescue
                  raise(PrecompileRequired)
                end
              end

              info('Skipping asset precompile, no asset diff found')

              # copy over all of the assets from the last release
              execute(:cp, '-r', latest_release_path.join('public', fetch(:assets_prefix)), release_path.join('public', fetch(:assets_prefix)))
            rescue PrecompileRequired
              execute(:rake, 'assets:precompile')
            end
          end
        end
      end
    end
  end
end
