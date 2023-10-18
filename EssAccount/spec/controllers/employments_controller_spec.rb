require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  describe '#add_employment' do
    it 'renders the employment fields partial using Turbo Streams' do
      employment = Employment.new
      allow(Employment).to receive(:new).and_return(employment)

      post :add_employment
      expect(response).to have_http_status(:success)
      expect(response.body).to include('turbo-stream')
      expect(response.body).to include('add-employment')
    end
  end

  describe '#create' do
    let(:personal_data) { create(:personal_data) }
    let(:employment_params) do
      {
        personal_data_id: personal_data.id,
        employer: ['Company A', 'Company B'],
        date_started: ['2022-01-01', '2023-01-01'],
        date_ended: ['2023-12-31', '2024-12-31']
      }
    end

    it 'creates employments and redirects to personal data' do
      post :create, params: { employment: employment_params }

      expect(response).to redirect_to(personal_datum_path(personal_data))

      employments = personal_data.employments
      expect(employments.count).to eq(2)
    end
  end
end
