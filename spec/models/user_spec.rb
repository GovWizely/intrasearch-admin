RSpec.describe User do
  describe '.create' do
    subject(:user) { User.new email: 'foo@example.org' }

    before do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post '/admin/users.json', {}, '{}'
      end
    end

    it 'sends send_reset_password_instructions' do
      expect(user).to receive(:send_reset_password_instructions)
      user.save
    end
  end
end
