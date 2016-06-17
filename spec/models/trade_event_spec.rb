RSpec.describe TradeEvent do
  describe '.site' do
    it 'should be defined' do
     expect(described_class.site.to_s).to eq('http://test.host.org:9292/admin/')
    end
  end
end
