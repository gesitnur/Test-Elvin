# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'apartment/elevators/subdomain'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Elvin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.eager_load_paths << Rails.root.join('lib')
    config.middleware.use Apartment::Elevators::Subdomain
    config.action_dispatch.tld_length = Integer(ENV['TLD_LENGTH'] || 2)

    # auto load libraries
    config.autoload_paths += %W(#{config.root}/lib/)
    config.time_zone = 'Jakarta'
    config.active_record.yaml_column_permitted_classes = [
      ActiveSupport::HashWithIndifferentAccess,
      ActiveSupport::TimeWithZone,
      ActiveSupport::TimeZone,
      BigDecimal,
      Symbol,
      Time
    ]
    config.time_zone = 'Asia/Jakarta'
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
