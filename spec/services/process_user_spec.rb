# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessUser do
  describe '#call' do
    subject(:process_user) { described_class.new(user:).call }

    context 'when user exists' do
      let(:saved_user) { Fabricate(:user, email: 'email@email.com') }

      context 'and user contents are updated' do
        let(:user) do
          {
            'id' => saved_user.id,
            'first_name' => saved_user.first_name,
            'last_name' => saved_user.last_name,
            'email' => 'email2@email.com',
            'status' => saved_user.status,
            'created_at' => saved_user.created_at
          }
        end

        it 'updates the email' do
          expect { process_user }.to change { saved_user.reload.email }.from('email@email.com').to('email2@email.com')
        end
      end

      context 'and user contents did not update' do
        let(:user) do
          {
            'id' => saved_user.id,
            'first_name' => saved_user.first_name,
            'last_name' => saved_user.last_name,
            'email' => saved_user.email,
            'status' => saved_user.status,
            'created_at' => saved_user.created_at
          }
        end

        it 'does not update the user' do
          expect { process_user }.not_to change { saved_user.reload }
        end
      end
    end

    context 'when user doesn\'t exist' do
      let(:expected_attributes) do
        {
          id: 1,
          first_name: 'Andre',
          last_name: 'Macedo',
          email: 'email2@email.com',
          status: 'Active'
        }
      end

      context 'and user contents are valid' do
        let(:user) do
          {
            'id' => 1,
            'first_name' => 'Andre',
            'last_name' => 'Macedo',
            'email' => 'email2@email.com',
            'status' => 'Active',
            'created_at' => '2020-09-30T20:12:46.769Z'
          }
        end

        it 'creates one new user' do
          expect { process_user }.to change { User.count }.from(0).to(1)
        end

        it 'creates a new user with the correct attributes' do
          process_user

          expect(User.first).to have_attributes(expected_attributes)
        end
      end

      context 'and user contents are invalid' do
        let(:user) do
          {
            'id' => 1,
            'first_name' => 'Andre',
            'last_name' => 'Macedo',
            'email' => 'email.com',
            'status' => 'Active',
            'created_at' => '2020-09-30T20:12:46.769Z'
          }
        end

        it 'raises an exception' do
          expect { process_user }.to raise_error ActiveRecord::RecordInvalid, 'Validation failed: Email is invalid'
        end
      end
    end
  end
end
