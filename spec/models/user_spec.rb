# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context '#filter_by_status' do
    let!(:active_user) { Fabricate(:user, status: 'Active') }
    let!(:inactive_user) { Fabricate(:user, status: 'Inactive') }

    it 'returns active users' do
      expect(User.filter_by_status('Active')).to eq([active_user])
    end

    it 'returns inactive users' do
      expect(User.filter_by_status('Inactive')).to eq([inactive_user])
    end

    it 'doesn\'t return invalid status' do
      expect(User.filter_by_status('all')).to be_empty
    end
  end

  context '#validations' do
    context 'validates email format' do
      let(:invalid_user_email) { Fabricate.build(:user, email: 'not_and_email') }
      let(:valid_user_email) { Fabricate.build(:user, email: 'an_email@email.com') }

      it 'accepts valid email' do
        expect(valid_user_email).to be_valid
      end

      it 'rejects valid email' do
        expect(invalid_user_email).not_to be_valid
      end
    end

    context 'valdates status' do
      let(:invalid_user_status) { Fabricate.build(:user, status: 'undefined') }
      let(:valid_user_status) { Fabricate.build(:user, status: 'Active') }

      it 'accepts valid status' do
        expect(valid_user_status).to be_valid
      end

      it 'rejects valid status' do
        expect(invalid_user_status).not_to be_valid
      end
    end
  end
end
