require 'rails_helper'

RSpec.describe PersonalDataController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_params) do
        { personal_data: attributes_for(:personal_data) }
      end

      it 'creates a new personal data record' do
        expect {
          post :create, params: valid_params, format: :turbo_stream
        }.to change(PersonalData, :count).by(1)
      end

      it 'renders a turbo stream response' do
        post :create, params: valid_params, format: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.body).to include('turbo-stream')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_params) do
        { personal_data: attributes_for(:personal_data, first_name: nil) }
      end

      it 'does not create a new personal data record' do
        expect {
          post :create, params: invalid_params
        }.not_to change(PersonalData, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
