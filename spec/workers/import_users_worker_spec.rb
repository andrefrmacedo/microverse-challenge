# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportUsersWorker do
  describe '#perform' do
    subject(:import_users_worker) { described_class.new.perform }

    let(:import_users_instance) { instance_double(ImportUsers) }

    before do
      allow(ImportUsers).to receive(:new).and_return(import_users_instance)
      allow(import_users_instance).to receive(:call)
    end

    it 'calls the correct service' do
      expect(import_users_instance).to receive(:call).once

      import_users_worker
    end
  end
end
