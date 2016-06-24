RSpec.shared_context 'user is logged in' do
  before do
    ActiveResource::HttpMock.respond_to do |mock|
      users_response_body = Rails.root.join('spec/fixtures/json/users.json').read
      mock.get '/admin/users.json', {}, users_response_body
      mock.get '/admin/users.json?email=admin%40example.org', {}, users_response_body

      admin_user_response_body = Rails.root.join('spec/fixtures/json/user_admin.json').read
      mock.get '/admin/users/AVV5bKhGLZFSYhIe3289.json', {}, admin_user_response_body
      mock.patch '/admin/users/AVV5bKhGLZFSYhIe3289.json', {}, '{}'
    end

    visit '/'
    fill_in 'Email', with: 'admin@example.org'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
