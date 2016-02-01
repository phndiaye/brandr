require 'rails_helper'

describe Api::V1::UsersController do
  describe '#GET me' do
    context 'there is no current user' do
      it 'should return an empty json' do
        get :me, format: :json

        expect(JSON.parse(response.body)).to eq({})
      end
    end

    context 'there is a current user' do
      let(:user) { create :user }
      let(:token) { double acceptable?: true, resource_owner_id: user.id }

      before { allow(controller).to receive(:doorkeeper_token) { token } }
      before { allow(controller).to receive(:current_user) { user } }

      it 'should return the serialized current user object' do
        get :me, format: :json

        expect(JSON.parse(response.body)['user']['email']).to eq(user.email)
      end
    end
  end

  describe '#POST create' do
    context 'everything went well' do
      let(:user_params) do
        {
          firstname: 'Eric',
          lastname: 'Cartman',
          email: 'ecartman@example.org',
          password: 'password123',
          password_confirmation: 'password123'
        }
      end

      it 'should return the newly created user' do
        post :create, format: :json, user: user_params

        expect(JSON.parse(response.body)['user']['email']).to eq(
          'ecartman@example.org'
        )
      end

      it 'should have 201 created as response status' do
        post :create, format: :json, user: user_params

        expect(response.status).to eq 201
      end
    end

    context 'an error occured when persisting the user' do
      let(:user_params) do
        {
          lastname: 'Cartman',
          email: 'ecartman@example.org',
          password: 'password123',
          password_confirmation: 'password123'
        }
      end

      context 'error concers a missing field' do
        it 'should return the error details' do
          post :create, format: :json, user: user_params

          expect(JSON.parse(response.body)['errors']).to eq({
            'firstname' => ["user.firstname.errors.blank"]
          })
        end
      end

      context 'a user already exists with this email address' do
        before { create(:user, email: 'ecartman@example.org') }

        let!(:user_params) do
          {
            firstname: 'Eric',
            lastname: 'Cartman',
            email: 'ecartman@example.org',
            password: 'password123',
            password_confirmation: 'password123'
          }
        end

        it 'should return an \'already taken\' error' do
          post :create, format: :json, user: user_params

          expect(JSON.parse(response.body)['errors']['email']).to eq(
            ["user.email.errors.taken"]
          )
        end
      end

      context 'the password confirmation does not match the password' do
        let!(:user_params) do
          {
            firstname: 'Eric',
            lastname: 'Cartman',
            email: 'ecartman@example.org',
            password: 'password123',
            password_confirmation: 'notmatchingthepassword'
          }
        end

        it 'should just say the password confirmation does not match the referenced password' do
          post :create, format: :json, user: user_params

          expect(JSON.parse(response.body)['errors']['password_confirmation']).to eq(
            ['user.password_confirmation.errors.confirmation']
          )
        end
      end
    end
  end
end
