require 'rails_helper'

describe Api::V2::EventsController do
  describe 'GET index' do
    let!(:events) { FactoryBot.create_list(:event, 10, :published) }
    let(:response_json) { JSON.parse(response.body) }

    before { get :index }

    it { expect(response.status).to eq 200 }
    it { expect(response_json.keys).to include('data', 'links', 'meta') }
    it { expect(response_json['data'].count).to eq 10 }
  end

  describe 'GET show' do
    context 'when event is published' do
      let(:published_event) { FactoryBot.create(:event, :published) }
      let(:response_json) { JSON.parse(response.body) }

      before { get :show, params: { id: published_event.id } }

      it { expect(response.status).to eq 200 }
      it { expect(response_json.keys).to include('data', 'included', 'links') }
      it { expect(response_json['data']['id']).to eq published_event.id.to_s }
    end

    context 'when event is unpublished' do
      let(:unpublished_event) { FactoryBot.create(:event) }

      before { get :show, params: { id: unpublished_event.id } }

      it { expect(response.status).to eq 404 }
      it { expect(response.body).to be_empty }
    end

    context 'when event id is invalid' do
      before { get :show, params: { id: FFaker::Guid.guid } }

      it { expect(response.status).to eq 404 }
      it { expect(response.body).to be_empty }
    end
  end
end
