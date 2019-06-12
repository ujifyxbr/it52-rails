describe SitemapsController do
  render_views

  describe 'GET index' do
    before do
      FactoryBot.create(:event, :published)
      get :index, format: :xml
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to be_ok }
    it { expect(response.content_type).to eq 'application/xml' }
  end
end
