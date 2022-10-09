# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessUsersWorker do
  describe '#perform' do
    subject(:process_users_worker) { described_class.new.perform(:user) }

    let(:user) do
      {
        id: 1,
        first_name: 'Andre',
        last_name: 'Macedo',
        email: 'email2@email.com',
        status: 'Active'
      }
    end
    let(:process_user_instance) { instance_double(ProcessUser) }

    before do
      allow(ProcessUser).to receive(:new).and_return(process_user_instance)
      allow(process_user_instance).to receive(:call)
    end

    it 'calls the correct service' do
      expect(process_user_instance).to receive(:call).once

      process_users_worker
    end
  end
end
