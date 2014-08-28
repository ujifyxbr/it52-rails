require 'spec_helper'

describe EventsController do
  context 'POST create' do
    let(:event_attrs) { FactoryGirl.attributes_for(:event) }
    let(:user) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :admin }

    context 'when user is anonymous' do
      it 'unlogged user cannot create event' do
        expect { post :create, event: event_attrs }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when user is logged in' do
      before { login_user user }
      it { expect { post :create, event: event_attrs }.to change(Event, :count).by 1 }
    end

    context 'when admin is logged in' do
      let(:admin) { FactoryGirl.create :admin }

      before { login_user admin }

      after { logout_user }

      it 'admin can create event' do
        post :create, event: event_attrs

        created_event = Event.first
        should redirect_to event_path(created_event)
      end

      it 'assigns organizer to event' do
        post :create, event: event_attrs
        created_event = Event.first
        expect(created_event.organizer).to eq admin
      end
    end
  end
end
