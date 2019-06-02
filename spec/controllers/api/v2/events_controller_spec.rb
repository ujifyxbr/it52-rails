require 'rails_helper'

describe Api::V2::EventsController do
  describe 'GET index' do
    let(:events) { FactoryBot.create_list(:event, 10) }

    before { get :index }

    it { expect(response.status).to eq 200 }
    it { expect(response.body.keys).to inlcude('data', 'links', 'meta') }
    it { expect(response.body['data'].count).to eq 10 }
  end
end
