set :application, 'task'
set :user, 'arkeus'
set :repo_url, 'https://github.com/arkeus/blackboard'
set :branch, 'master'
set :deploy_to, "/home/arkeus/blackboard"

set :rvm_type, :user
set :rvm_ruby_version, 'ruby-1.9.3-p125'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
	
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
end
