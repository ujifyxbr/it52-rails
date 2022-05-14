# frozen_string_literal: true

describe Api::V2::TagsController do
  before_all do
    create(:event, tag_list: ['js'])
    create(:event, tag_list: %w[js rannts])
    create(:event, tag_list: %w[js rambler rannts])
  end

  describe 'GET index' do
    let(:default_attrs) { { id: an_instance_of(String), type: 'tag' } }

    context 'without search query' do
      before { get :index }

      let(:response_data) do
        [
          default_attrs.merge(attributes: { name: 'js', taggingsCount: 3 }),
          default_attrs.merge(attributes: { name: 'rannts', taggingsCount: 2 }),
          default_attrs.merge(attributes: { name: 'rambler', taggingsCount: 1 })
        ].map(&:deep_stringify_keys)
      end

      it 'returns valid response' do
        expect(response).to have_http_status(:ok)
        expect(response_body).to match({ data: response_data, meta: { totalCount: 3 } }.deep_stringify_keys)
      end
    end

    context 'with search query' do
      before { get :index, params: { q: 'ra' } }

      let(:response_data) do
        [
          default_attrs.merge(attributes: { name: 'rannts', taggingsCount: 2 }),
          default_attrs.merge(attributes: { name: 'rambler', taggingsCount: 1 })
        ].map(&:deep_stringify_keys)
      end

      it 'returns valid response' do
        expect(response).to have_http_status(:ok)
        expect(response_body).to match({ data: response_data, meta: { totalCount: 2 } }.deep_stringify_keys)
      end
    end
  end
end
