require 'rails_helper'

describe Api::V2::TagsController do
  describe 'GET index' do
    before(:all) do
      FactoryBot.create(:event, tag_list: ['js'])
      FactoryBot.create(:event, tag_list: ['js', 'rannts'])
      FactoryBot.create(:event, tag_list: ['js', 'rambler', 'rannts'])
    end

    let(:response_json) { JSON.parse(response.body) }
    let(:default_attrs) { { id: an_instance_of(String), type: 'tag' } }

    context 'without search query' do
      before { get :index }

      let(:response_data) {
        [
          default_attrs.merge(attributes: { name: 'js', taggingsCount: 3 }).deep_stringify_keys,
          default_attrs.merge(attributes: { name: 'rannts', taggingsCount: 2 }).deep_stringify_keys,
          default_attrs.merge(attributes: { name: 'rambler', taggingsCount: 1 }).deep_stringify_keys
        ]
      }

      it { expect(response.status).to eq 200 }
      it { expect(response_json.keys).to include('data', 'meta') }
      it { expect(response_json).to match({ data: response_data, meta: { totalCount: 3 }}.deep_stringify_keys) }
    end

    context 'with search query' do
      before { get :index, params: { q: 'ra' } }

      let(:response_data) {
        [
          default_attrs.merge(attributes: { name: 'rannts', taggingsCount: 2 }).deep_stringify_keys,
          default_attrs.merge(attributes: { name: 'rambler', taggingsCount: 1 }).deep_stringify_keys
        ]
      }

      it { expect(response.status).to eq 200 }
      it { expect(response_json.keys).to include('data', 'meta') }
      it { expect(response_json).to match({ data: response_data, meta: { totalCount: 2 }}.deep_stringify_keys) }
    end
  end
end
