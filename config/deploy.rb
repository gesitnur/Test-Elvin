# frozen_string_literal: true

lock '~> 3.17.1'

set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, '/home/deploy/.rbenv/bin/rbenv exec'

set :application, 'elvin'
set :repo_url, 'git@github.com:3lviend/elvin.git'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :user, 'deploy'
set :pty, true
set :tmp_dir, '/home/deploy/tmp'

set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/puma.rb'
)

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle', 'public/packs'
)
set :whenever_staging, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

set :keep_releases, 4

namespace :deploy do
  desc '========Restart puma, sidekiq========'
  task :restart do
    on roles :app do
      # execute(:sudo, :service, "puma restart")
      # execute(:sudo, :service, "nginx restart")
      # execute(:sudo, :service, "sidekiq restart")
    end
  end
end

# before 'deploy:assets:precompile', 'deploy:clobber_assets'

after 'deploy:finishing', 'deploy:restart'
after 'deploy:publishing', 'deploy:restart'
