require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "mybookings"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Devise.setup do |config|
      # Devise generics
      config.omniauth_path_prefix = '/users/auth'
      config.parent_controller = 'Mybookings::ApplicationController'

      # Omniauth
      idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
      idp_settings = idp_metadata_parser.parse_remote(Rails.application.secrets.saml_idp_metadata_target_url)

      config.omniauth :saml, {
        name: Rails.application.secrets.saml_provider_name,
        issuer: Rails.application.secrets.saml_issuer,
        idp_sso_target_url: idp_settings.idp_sso_target_url,
        idp_cert_fingerprint: idp_settings.idp_cert_fingerprint,
        idp_cert_fingerprint_algorithm: idp_settings.idp_cert_fingerprint_algorithm,
        idp_attribute_names: idp_settings.idp_attribute_names,
        idp_slo_target_url: idp_settings.idp_slo_target_url,
        idp_entity_id: idp_settings.idp_entity_id,
        name_identifier_format: idp_settings.name_identifier_format,
        private_key: Rails.application.secrets.saml_private_key,
        certificate: Rails.application.secrets.saml_certificate
      }
    end

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
