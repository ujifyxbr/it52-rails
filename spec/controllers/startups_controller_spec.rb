require 'rails_helper'

RSpec.describe StartupsController, type: :controller do
  let!(:user) { FactoryBot.create :user }
  let!(:other_user) { FactoryBot.create :user }
  let(:admin) { FactoryBot.create :admin }

  let(:valid_attributes) { FactoryBot.attributes_for(:startup) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:startup).merge(title: nil) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      startup = Startup.create! valid_attributes
      get :show, params: { id: startup.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    let(:new_request) { get :new }

    context 'when user is anonymous' do
      before { new_request }

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when user is signed in' do
      before do
        sign_in user
        new_request
      end

      it { expect(response).to be_successful }
    end
  end

  describe "GET #edit" do
    let(:startup) { FactoryBot.create(:startup, author: user) }
    let(:edit_request) { get :edit, params: { id: startup.to_param } }

    context 'when user is anonymous' do
      before { edit_request }

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when other user is signed in' do
      before do
        sign_in other_user
        edit_request
      end

      it { expect(response.status).to redirect_to root_path }
      it { expect(flash[:error]).to eq 'You are not authorized to access this page.' }
    end

    context 'when author is signed in' do
      before do
        sign_in user
        edit_request
      end

      it { expect(response).to be_successful }
    end

    context 'when admin is signed in' do
      before do
        sign_in admin
        edit_request
      end

      it { expect(response).to be_successful }
    end
  end

  describe "POST #create" do
    let(:create_request) { post :create, params: { startup: valid_attributes } }

    context 'when user is anonymous' do
      before { create_request }

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid params'do
        it { expect { create_request }.to change { Startup.count }.from(0).to(1) }
      end

      context 'with invalid params'do
        let(:create_request) { post :create, params: { startup: invalid_attributes } }

        it { expect { create_request }.not_to change { Startup.count } }
      end
    end
  end

  describe "PUT #update" do
    let(:startup) { FactoryBot.create(:startup, author: user) }
    let(:update_request) { put :update, params: { id: startup.to_param,  startup: valid_attributes } }

    context 'when user is anonymous' do
      before { update_request }

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when other user is signed in' do
      before do
        sign_in other_user
        update_request
      end

      it { expect(response).to redirect_to root_path }
    end

    context 'when user is signed in' do
      before { sign_in user }

      # context 'with valid params'do
      #   it { expect { update_request }.to change { startup.title }.from(startup.title).to(valid_attributes[:title]) }
      # end

      context 'with invalid params'do
        let(:update_request) { put :update, params: { id: startup.to_param,  startup: invalid_attributes } }

        it { expect { update_request }.not_to change { startup.title } }
      end
    end
  end
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested startup" do
  #       startup = Startup.create! valid_attributes
  #       put :update, params: {id: startup.to_param, startup: new_attributes}, session: valid_session
  #       startup.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the startup" do
  #       startup = Startup.create! valid_attributes
  #       put :update, params: {id: startup.to_param, startup: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(startup)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       startup = Startup.create! valid_attributes
  #       put :update, params: {id: startup.to_param, startup: invalid_attributes}, session: valid_session
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested startup" do
  #     startup = Startup.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: startup.to_param}, session: valid_session
  #     }.to change(Startup, :count).by(-1)
  #   end

  #   it "redirects to the startups list" do
  #     startup = Startup.create! valid_attributes
  #     delete :destroy, params: {id: startup.to_param}, session: valid_session
  #     expect(response).to redirect_to(startups_url)
  #   end
  # end

end
