RSpec.describe TradeEventsController, type: :controller do
  before { expect(controller).to receive(:authenticate_user!) }

  describe '#update' do
    context 'when update failed' do
      let(:trade_event) { double(TradeEvent) }

      before do
        expect(TradeEvent).to receive(:find).with('36282').and_return(trade_event)
      end

      it 'renders :edit' do
        expect(trade_event).to receive(:update_attributes).
          with(md_description: '# description').
          and_return(false)
        patch :update, id: '36282', trade_event: { md_description: '# description' }

        expect(response).to have_rendered(:edit)
      end
    end
  end
end
