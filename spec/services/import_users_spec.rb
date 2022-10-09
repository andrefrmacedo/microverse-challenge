# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportUsers do
  describe '#call' do
    subject(:import_users) { described_class.new.call }

    let(:api_instance) { instance_double(ApiClient) }
    let(:get_users) { instance_double(api_instance.get_users) }

    before do
      allow(ApiClient).to receive(:new).and_return(api_instance)
      allow(ProcessUsersWorker).to receive(:perform_async)
    end

    context 'when api call fails' do
      before do
        allow(api_instance).to receive(:get_users).and_raise(RestClient::ExceptionWithResponse)
      end

      it 'raises error' do
        expect { import_users }.to raise_error RestClient::ExceptionWithResponse
      end
    end

    context 'when api response is empty' do
      before do
        allow(api_instance).to receive(:get_users).and_return(JSON.dump([]))
      end

      it 'doesn\'t call the worker' do
        expect(ProcessUsersWorker).not_to receive(:perform_async)

        import_users
      end
    end

    context 'when api response is successful' do
      let(:api_response) do
        [
          {
            id: 1,
            first_name: 'Merlin',
            last_name: 'Sawayn',
            email: 'juliusjohns@mcclure.net',
            status: 'Active',
            created_at: '2020-09-30T20:12:46.769Z'
          }
        ]
      end
      before do
        allow(api_instance).to receive(:get_users).and_return(JSON.dump(api_response), JSON.dump([]))
      end

      it 'calls the worker' do
        expect(ProcessUsersWorker).to receive(:perform_async).once

        import_users
      end
    end
  end
end
