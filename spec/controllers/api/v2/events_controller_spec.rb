# frozen_string_literal: true

describe Api::V2::EventsController do
  describe 'GET index' do
    before do
      create_list(:event, 3, :published)
      create_list(:event, 2)
      get :index
    end

    it 'returns correct response' do
      expect(response).to have_http_status(:ok)
      expect(response_body.keys).to include('data', 'links', 'meta')
      expect(response_body['data'].count).to eq 3
    end
  end

  describe 'GET show' do
    context 'when event is published' do
      let(:published_event) { create(:event, :published) }

      before { get :show, params: { id: published_event.id } }

      it 'returns correct response' do
        expect(response).to have_http_status(:ok)
        expect(response_body.keys).to include('data', 'included', 'links')
        expect(response_body['data']['id']).to eq published_event.id.to_s
      end
    end

    context 'when event is unpublished' do
      let(:unpublished_event) { create(:event) }

      before { get :show, params: { id: unpublished_event.id } }

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
        expect(response_body).to be_empty
      end
    end

    context 'when event id is invalid' do
      before { get :show, params: { id: FFaker::Guid.guid } }

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
        expect(response_body).to be_empty
      end
    end
  end
end
