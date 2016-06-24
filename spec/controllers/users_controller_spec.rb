RSpec.describe UsersController, type: :controller do
  before { expect(controller).to receive(:authenticate_user!) }

  describe '#index' do
    let(:all_users) { double('all users') }

    it 'assigns all users to @users' do
      expect(User).to receive(:all).and_return(all_users)
      get :index
      expect(assigns(:users)).to eq(all_users)
    end
  end

  describe '#new' do
    it 'assigns @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe '#create' do
    let(:user) { double('User', email: 'foo@example.org') }

    before do
      expect(User).to receive(:new).with(email: 'foo@example.org').and_return(user)
      ActiveResource::HttpMock.respond_to(false) do |mock|
        mock.post '/admin/users.json', {}, '{}'
      end
    end

    context 'when create params are valid' do
      it 'redirects to root_path' do
        expect(user).to receive(:save).and_return(true)
        post :create, user: { email: 'foo@example.org' }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the create params are invalid' do
      it 'renders new' do
        expect(user).to receive(:save).and_return(false)
        post :create, user: { email: 'foo@example.org' }

        expect(response).to have_rendered(:new)
      end
    end
  end
end
