require 'support/shared_user_contexts'

RSpec.describe 'trade leads', type: :feature do
  context 'when logged in' do
    include_context 'user is logged in'

    before do
      ActiveResource::HttpMock.respond_to(false) do |mock|
        trade_leads_response_body = Rails.root.join('spec/fixtures/json/trade_leads_limit_30_offset_0.json').read
        mock.get '/admin/trade_leads.json?limit=30&offset=0', {}, trade_leads_response_body

        %w(id_australia id_canada id_fbo id_mca).each do |id|
          trade_lead_show_response_body = Rails.root.join("spec/fixtures/json/trade_lead_#{id}.json").read
          mock.get "/admin/trade_leads/#{id}.json", {}, trade_lead_show_response_body
        end

        mock.patch '/admin/trade_leads/id_fbo.json', {}, '{}'

        errors_json = { errors: { md_description: ['bad description'] } }.to_json
        mock.patch '/admin/trade_leads/id_mca.json', {}, errors_json, 422

        mock.get '/admin/trade_leads/id_not_found.json', {}, nil, 404
      end
    end

    context 'when visiting an Australia trade lead page' do
        before do
          visit '/'
          click_link 'Trade Leads'
        end

        it 'show trade lead attributes' do
          click_link 'Lead Professional Advice on Innovation System Strategic Planning'
          expect(page).to have_link('a', href: 'https://example.org/trade_lead?id=id_australia')
          expect(page).to have_selector('li', text: 'eCommerce Industry')
        end
    end

    context 'when visiting a trade lead page with URLs' do
      before do
        visit '/trade_leads/id_canada'
      end

      it 'show trade lead attributes' do
        expect(page).to have_link('a', href: 'https://tradelead.example.org/canada/1%20with%20spaces.pdf')
      end
    end

    context 'when successfully update a trade lead' do
      before do
        visit '/trade_leads'
        first('a', text: 'Edit').click
        fill_in 'Markdown description', with: '# my trade lead description'
        click_button 'Save'
      end

      it 'renders successful message' do
        expect(page).to have_content 'You have successfully save this trade lead'
      end
    end

    context 'when failed update a trade lead' do
      before do
        visit '/trade_leads'
        click_link 'Purchase of Computer Equipment Lead'
        click_link 'Edit'
        fill_in 'Markdown description', with: '# my trade lead description'
        click_button 'Save'
      end

      it 'renders errors message' do
        expect(page).to have_content 'bad description'
      end
    end

    context 'when a trade lead is not found' do
      before do
        visit '/trade_leads'
        click_link 'Missing Lead'
      end

      it 'renders alert' do
        expect(page).to have_content 'Trade lead not found'
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

    context 'when visiting Trade Leads page' do
      before { visit '/trade_leads' }

      it 'goes to log in page' do
        expect(page).to have_button 'Log in'
      end
    end
  end
end
