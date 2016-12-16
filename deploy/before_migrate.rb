deploy = new_resource
env_vars = new_resource.environment

require 'securerandom'

template_config = {
  'devise.yml' => {
    environment: env_vars['RAILS_ENV'],
    mailer_sender: node['intrasearch_admin_data']['devise_mailer_sender']
  },
  'intrasearch.yml' => {
    environment: env_vars['RAILS_ENV'],
    host_url: node['intrasearch_admin']['intrasearch_host_url']
  },
  'intrasearch_admin.yml' => {
    environment: env_vars['RAILS_ENV'],
    action_mailer_url_host: node['intrasearch_admin']['action_mailer_url_host'],
    action_mailer_url_port: node['intrasearch_admin']['action_mailer_url_port'],
    smtp_address: env_vars['smtp_address'],
    smtp_user_name: env_vars['smtp_user_name'],
    smtp_password: env_vars['smtp_password']
  }
}

template_config.each do |filename, vars|
  template "#{deploy.deploy_to}/shared/config/#{filename}" do
    source "#{release_path}/config/#{filename}.erb"
    local true
    mode '0400'
    group deploy.group
    owner deploy.user
    variables vars
  end
end

template "#{deploy.deploy_to}/shared/config/secrets.yml" do
  source "#{release_path}/config/secrets.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables(
    environment: env_vars['RAILS_ENV'],
    secret_key_base: SecureRandom.hex(64)
  )
  not_if { ::File.exist?("#{deploy.deploy_to}/shared/config/secrets.yml") }
end
