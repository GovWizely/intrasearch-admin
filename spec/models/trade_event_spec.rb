RSpec.describe TradeEvent do
  describe '.site' do
    it 'should be defined' do
     expect(described_class.site.to_s).to eq('http://test.host.org:9292/admin/')
    end
  end

  describe '#patch_attributes' do
    before do
      ActiveResource::HttpMock.respond_to do |mock|
        trade_event_show_response_body = Rails.root.join('spec/fixtures/json/trade_event_ita.json').read
        mock.get '/admin/trade_events/ita.json', {}, trade_event_show_response_body
        mock.patch '/admin/trade_events/ita.json', {}, '{}'
      end
    end

    it 'generates HTML description' do
      trade_event = TradeEvent.find 'ita'
      trade_event.update_attributes(md_description: '# foo')
      expect(trade_event).to be_persisted
      expect(trade_event.html_description).to eq('<h1>foo</h1>')
    end
  end
end
