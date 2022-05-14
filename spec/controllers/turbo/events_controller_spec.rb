# frozen_string_literal: true

describe Turbo::EventsController do
  render_views

  describe 'GET index' do
    before do
      create(:event, :published)
      create(:event)
      get :index, format: :rss
    end

    it 'returns valid response' do
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/rss+xml'
      expect(Nokogiri::XML(response.body).css('channel item').count).to eq 1
    end
  end
end
