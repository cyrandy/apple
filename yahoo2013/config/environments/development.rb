Yahoo2013::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  SITE_ROOT = "http://silence.twbbs.org"

  FB_APP_ID = "215340905195586"
  FB_SECRET = "89fc7f31748f4cd26f7b954771fe33a8"
  FB_APP_SITE = "http://apps.facebook.com/testnope"

  Y_KEY = "dj0yJmk9MnV0RTJVNnJoNkhWJmQ9WVdrOVV6ZDRVRmMwTXpJbWNHbzlPVGsyTXpBM05UWXkmcz1jb25zdW1lcnNlY3JldCZ4PTdi"
  Y_SECRET = "d2b1f744876c2c0a782d05f6b0df6d5d6a8ccd87"
end
