require 'configurator'

Rails.application.configure do
  Configurator.configure nil, 'intrasearch_admin.yml' do |yaml|
    action_mailer_hash = yaml['action_mailer']
    config.action_mailer.default_url_options = action_mailer_hash['default_url_options']
    config.action_mailer.smtp_settings = action_mailer_hash['smtp_settings'] if action_mailer_hash['smtp_settings']
  end
end
