describe EventsController do
  let!(:user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }

  describe 'POST create' do
    let(:event_attrs) { FactoryBot.attributes_for(:event) }

    context 'when user is anonymous' do
      it 'unlogged user cannot create event' do
        expect(post :create, params: { event: event_attrs }).to redirect_to new_user_session_path
      end

      it { expect(get :new).to redirect_to new_user_session_path }
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
    let!(:event) { FactoryBot.create(:event) }
    let(:delete_request) { delete :destroy, params: { id: event.id } }

    context 'when user is anonymous' do
      it { expect(delete_request).to redirect_to new_user_session_path }
      it { expect { delete_request }.not_to change(Event, :count) }
    end

    context 'when user logged in' do
      before { sign_in user }

      it { expect(delete_request).to redirect_to new_user_session_path }
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
