require 'support/shared_user_contexts'

RSpec.describe 'trade events', type: :feature do
  context 'when logged in' do
    include_context 'user is logged in'

    before do
      ActiveResource::HttpMock.respond_to(false) do |mock|
        trade_events_response_body = Rails.root.join('spec/fixtures/json/trade_events_limit_30_offset_0.json').read
        mock.get '/admin/trade_events.json?limit=30&offset=0', {}, trade_events_response_body

        trade_event_show_response_body = Rails.root.join('spec/fixtures/json/trade_event_36282.json').read
        mock.get '/admin/trade_events/36282.json', {}, trade_event_show_response_body

        mock.patch '/admin/trade_events/36282.json', {}, '{}'

        mock.get '/admin/trade_events/94c68284a1b7698becdcdaa69dda29bb2d76051c.json', {}, nil, 404
      end
    end

    context 'when visiting Trade Events page' do
      before do
        visit '/'
        click_link 'Trade Events'
      end

      it 'lists trade events' do
        expect(page).to have_content('Trade Event 36282')
        click_link 'Trade Event 36282'
        expect(page).to have_selector('a', text: 'example.org/trade_event?id=36282')
      end
    end

    context 'when successfully update a trade event' do
      before do
        visit '/trade_events'
        first('a', text: 'Edit').click
        fill_in 'Md description', with: '# my trade event description'
        click_button 'Save'
      end

      it 'renders successful message' do
        expect(page).to have_content 'You have successfully save this trade event'
      end
    end

    context 'when a trade event is not found' do
      before do
        visit '/trade_events'
        click_link 'DL Trade Event 1'
      end

      it 'renders alert' do
        expect(page).to have_content 'Trade event not found'
      end
    end
  end

  context 'when not logged in' do
    context 'when visiting home page' do
      before { visit '/' }

      it 'goes to log in page' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'when visiting Trade Events page' do
      before { visit '/trade_events' }

      it 'goes to log in page' do
        expect(page).to have_button 'Log in'
      end
    end
  end
end
