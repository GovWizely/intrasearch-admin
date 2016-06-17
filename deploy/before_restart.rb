deploy = {
  'user' => new_resource.user,
  'group' => new_resource.group,
  'cwd' => release_path,
  'environment' => new_resource.environment.merge(
    'PATH' => "/home/#{new_resource.user}/.rbenv/shims:/usr/bin:/bin"
  )
}

execute 'rake assets:precompile assets:clean' do
  user deploy['user']
  group deploy['group']
  cwd deploy['cwd']
  environment deploy['environment']
  command 'bundle exec rake assets:precompile assets:clean'
end
