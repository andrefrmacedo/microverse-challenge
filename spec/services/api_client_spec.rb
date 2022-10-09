# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiClient do
  describe '#ge_users' do
    subject(:get_users) { described_class.new.get_users(limit:, offset:) }

    let(:limit) { 20 }
    let(:offset) { 0 }

    context 'When api call fails' do
      before do
        stub_request(:get, "#{ApiClient::BASE_URL}/users?limit=#{limit}&offset=#{offset}")
          .with(headers: { 'Authorization' => Rails.application.credentials.fetch(:api_key) })
          .to_return(status: 400)
      end

      it 'raises error' do
        expect { get_users }.to raise_error RestClient::BadRequest
      end
    end

    context 'when api call is successful' do
      let(:response_body) do
        JSON.dump(
          {
            id: 1,
            first_name: 'Andre',
            last_name: 'Macedo',
            email: 'email2@email.com',
            status: 'Active'
          }
        )
      end

      before do
        stub_request(:get, "#{ApiClient::BASE_URL}/users?limit=#{limit}&offset=#{offset}")
          .with(headers: { 'Authorization' => Rails.application.credentials.fetch(:api_key) })
          .to_return(body: response_body)
      end

      it { is_expected.to eq(response_body) }
    end
  end
end
