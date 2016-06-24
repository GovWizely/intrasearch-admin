require 'rake'

RSpec.describe 'add_user.rake' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require('tasks/add_user')
    Rake::Task.define_task(:environment)
  end

  describe 'intrasearch_admin:add_user' do
    it 'adds user' do
      expect(User).to receive(:create).with(email: 'user1@bar.com')
      expect(User).to receive(:create).with(email: 'user2@bar.com')

      @rake['intrasearch_admin:add_user'].invoke 'user1@bar.com,user2@bar.com'
    end
  end
end
