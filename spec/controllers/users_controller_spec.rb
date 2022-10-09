# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { Fabricate(:user, first_name: 'Andre', last_name: 'Macedo', status: 'Active') }

  describe '#index' do
    context 'when format is html' do
      it 'renders the index template' do
        get :index, format: :html

        expect(response).to render_template :index
      end

      it 'returns a successful response' do
        get :index, format: :html

        expect(response).to be_successful
      end

      it 'assigns @users' do
        get :index, format: :html

        expect(assigns(:users)).to eq([user])
      end
    end

    context 'when format is json' do
      let(:expected_response) do
        {
          'first_name' => 'Andre',
          'last_name' => 'Macedo',
          'status' => 'Active'
        }
      end

      it 'returns a successful response' do
        get :index, format: :json

        expect(JSON.parse(response.body).first).to include(expected_response)
      end
    end

    context 'when filtered by status' do
      let(:inactive_user) { Fabricate(:user, status: 'Inactive') }
      context 'and status is Active' do
        it 'assigns @users with the active status' do
          get :index, params: { status: 'Active' }, format: :html

          expect(assigns(:users)).to eq([user])
        end
      end

      context 'and status is Inactive' do
        it 'assigns @users with the inactive status' do
          get :index, params: { status: 'Inactive' }, format: :html

          expect(assigns(:users)).to eq([inactive_user])
        end
      end

      context 'and status is not valid' do
        it 'doesn not assign any @users' do
          get :index, params: { status: 'something' }, format: :html

          expect(assigns(:users)).to eq([])
        end
      end
    end
  end

  describe '#show' do
    context 'when format is html' do
      it 'renders the index template' do
        get :show, params: { id: user.id }, format: :html

        expect(response).to render_template :show
      end

      it 'returns a successful response' do
        get :show, params: { id: user.id }, format: :html

        expect(response).to be_successful
      end

      it 'assigns @user' do
        get :show, params: { id: user.id }, format: :html

        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when format is json' do
      let(:expected_response) do
        {
          'first_name' => 'Andre',
          'last_name' => 'Macedo',
          'status' => 'Active'
        }
      end
      before do
        request.accept = 'application/json'
      end

      it 'returns a successful response' do
        get :show, params: { id: user.id }, format: :json

        expect(JSON.parse(response.body)).to include(expected_response)
      end
    end
  end
end
