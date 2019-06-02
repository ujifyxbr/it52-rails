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
end
