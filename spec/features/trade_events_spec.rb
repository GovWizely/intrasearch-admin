RSpec.describe 'trade events', type: :feature do
  before do
    ActiveResource::HttpMock.respond_to do |mock|
      trade_events_response_body = Rails.root.join('spec/fixtures/json/trade_events_limit_30_offset_0.json').read
      mock.get '/admin/trade_events.json?limit=30&offset=0', {}, trade_events_response_body

      trade_event_response_body = Rails.root.join('spec/fixtures/json/trade_event_36282.json').read
      mock.get '/admin/trade_events/36282.json', {}, trade_event_response_body
    end
  end

  it 'lists trade events' do
    visit '/'
    click_link 'Trade Events'
    expect(page).to have_content('Trade Event 36282')
    click_link 'Trade Event 36282'
    expect(page).to have_content('https://example.org/trade_event?id=36282')
  end
end
