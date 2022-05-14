# frozen_string_literal: true

describe EventsController do
  let_it_be(:user) { create :user }
  let_it_be(:admin) { create :admin }

  describe 'GET participants' do
    let_it_be(:organizer) { create :user }
    let_it_be(:event) { create(:event, organizer: organizer) }

    let(:participants_request) { get :participants, params: { id: event.id, format: :csv } }

    context 'when user is anonymous' do
      before { participants_request }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when user is logged in' do
      before do
        sign_in user
        participants_request
      end

      it { expect(response).to redirect_to root_path }
    end

    context 'when organizer is logged in' do
      before do
        sign_in organizer
        participants_request
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'when admin is logged in' do
      before do
        sign_in admin
        participants_request
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'POST create' do
    let(:event_attrs) { attributes_for(:event) }

    context 'when user is anonymous' do
      it 'unlogged user cannot create event' do
        expect(post(:create, params: { event: event_attrs })).to redirect_to new_user_session_path
      end

      it { expect(get(:new)).to redirect_to new_user_session_path }
    end

    context 'when user is logged in' do
      before { sign_in user }

      it { expect { post :create, params: { event: event_attrs } }.to change(Event, :count).by 1 }
    end

    context 'when admin is logged in' do
      let(:created_event) { Event.find_by(title: event_attrs[:title]) }

      before { sign_in admin }

      context 'after event creating' do
        before { post :create, params: { event: event_attrs } }

        it 'redirect to event page after event creating' do
          expect(request).to redirect_to event_path(created_event)
        end

        it 'assigns organizer to event' do
          expect(created_event.organizer).to eq admin
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:event) { create(:event) }
    let(:delete_request) { delete :destroy, params: { id: event.id } }

    context 'when user is anonymous' do
      it { expect(delete_request).to redirect_to new_user_session_path }
      it { expect { delete_request }.not_to change(Event, :count) }
    end

    context 'when user logged in' do
      before { sign_in user }

      it { expect(delete_request).to redirect_to root_path }
      it { expect { delete_request }.not_to change(Event, :count) }
    end

    context 'when user is organizer' do
      before do
        event.update(organizer: user)
        sign_in user
      end

      context 'and event is unpublished' do
        it { expect(delete_request).to redirect_to root_path }
        it { expect { delete_request }.to change(Event, :count).by(-1) }
      end

      context 'and event is published' do
        before { event.publish! }

        it { expect(delete_request).to redirect_to root_path }
        it { expect { delete_request }.not_to change(Event, :count) }
      end
    end

    context 'when user is admin' do
      before do
        event.update(organizer: admin)
        sign_in admin
      end

      context 'and event is unpublished' do
        it { expect(delete_request).to redirect_to root_path }
        it { expect { delete_request }.to change(Event, :count).by(-1) }
      end

      context 'and event is published' do
        before { event.publish! }

        it { expect(delete_request).to redirect_to root_path }
        it { expect { delete_request }.not_to change(Event, :count) }
      end
    end
  end
end
