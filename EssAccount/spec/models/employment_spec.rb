require 'rails_helper'

RSpec.describe Employment, type: :model do
  describe 'validations' do
    subject(:employment) { build(:employment) }

    it { is_expected.to be_valid }

    context 'when employer is not present' do
      before { employment.employer = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when date_started is not present' do
      before { employment.date_started = nil }
      it { is_expected.not_to be_valid }
    end

    context 'when date_ended is not present' do
      before { employment.date_ended = nil }
      it { is_expected.not_to be_valid }
    end
  end
end
