describe SitemapsController do
  render_views
  before(:all) { FactoryBot.create(:event, :published) }

  describe 'GET index' do
    before { get :index, format: :xml }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to be_ok }
    it { expect(response.content_type).to eq 'application/xml' }
  end
end
