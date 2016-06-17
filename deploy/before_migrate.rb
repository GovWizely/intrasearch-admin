deploy = new_resource
env_vars = new_resource.environment

require 'securerandom'

template "#{deploy.deploy_to}/shared/config/intrasearch.yml" do
  source "#{release_path}/config/intrasearch.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables(
    environment: env_vars['RAILS_ENV'],
    host_url: node['intrasearch_admin']['intrasearch_host_url']
  )
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
