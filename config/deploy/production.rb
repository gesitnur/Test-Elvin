# frozen_string_literal: true

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w[publickey],
  user: 'deploy'
}

set :rails_env, :production

set :stage, :production

server '134.209.108.64', user: 'deploy', roles: %w[app db web]

set :deploy_to, '/home/deploy/elvin'

# set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'prod-v0'
