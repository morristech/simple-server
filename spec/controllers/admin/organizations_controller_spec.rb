require 'rails_helper'

RSpec.describe Admin::OrganizationsController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:organization)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:organization, name: nil)
  }

  before do
    sign_in(create(:admin))
  end

  describe 'GET #index' do
    it 'returns a success response' do
      organization = Organization.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      organization = Organization.create! valid_attributes
      get :show, params: { id: organization.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      organization = Organization.create! valid_attributes
      get :edit, params: { id: organization.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Organization' do
        expect {
          post :create, params: { organization: valid_attributes }
        }.to change(Organization, :count).by(1)
      end

      it 'redirects to the created organization' do
        post :create, params: { organization: valid_attributes }
        expect(response).to redirect_to([:admin, Organization.last])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { organization: invalid_attributes }
        expect(response).to be_success
      end
    end

  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        FactoryBot.attributes_for(:organization).except(:id)
      }

      it 'updates the requested organization' do
        organization = Organization.create! valid_attributes
        put :update, params: { id: organization.to_param, organization: new_attributes }
        organization.reload
        expect(response).to redirect_to([:admin, organization])
        expect(organization.attributes.except('id', 'created_at', 'updated_at', 'deleted_at'))
          .to eq new_attributes.with_indifferent_access
      end

      it 'redirects to the organization' do
        organization = Organization.create! valid_attributes
        put :update, params: { id: organization.to_param, organization: valid_attributes }
        expect(response).to redirect_to([:admin, organization])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        organization = Organization.create! valid_attributes
        put :update, params: { id: organization.to_param, organization: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested organization' do
      organization = Organization.create! valid_attributes
      expect {
        delete :destroy, params: { id: organization.to_param }
      }.to change(Organization, :count).by(-1)
    end

    it 'redirects to the organizations list' do
      organization = Organization.create! valid_attributes
      delete :destroy, params: { id: organization.to_param }
      expect(response).to redirect_to(admin_organizations_url)
    end
  end
end