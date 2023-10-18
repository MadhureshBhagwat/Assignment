require 'rails_helper'

RSpec.describe PersonalData, type: :model do
  describe 'validations' do
    subject(:personal_data) { build(:personal_data) }

    it { is_expected.to be_valid }

    context 'when first name is not present' do
      before { personal_data.first_name = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when last name is not present' do
      before { personal_data.last_name = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when email is not present' do
      before { personal_data.email = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when email is a duplicate' do
      before { create(:personal_data, email: personal_data.email) }
      it { is_expected.not_to be_valid }
    end

    context 'when phone number is not present' do
      before { personal_data.phone_number = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when first name is longer than 25 characters' do
      before { personal_data.first_name = Faker::Lorem.characters(number: 26) }
      it { is_expected.not_to be_valid }
    end

    context 'when last name is longer than 50 characters' do
      before { personal_data.last_name = Faker::Lorem.characters(number: 51) }
      it { is_expected.not_to be_valid }
    end
  end
end
