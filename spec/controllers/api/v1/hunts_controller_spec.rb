require 'rails_helper'

describe Api::V1::HuntsController do
  let(:user) { create :user }
  let(:token) { double acceptable?: true, resource_owner_id: user.id }

  before { allow(controller).to receive(:doorkeeper_token) { token } }
  before { allow(controller).to receive(:current_user) { user } }

  context 'no current user' do
    let!(:token) { nil }

    it 'should return an unauthorized access error' do
      post :create, format: :json, hunt: {}
      expect(JSON.parse(response.body)['error']).to eq 'Unauthorized Access'
    end
  end

  describe '#GET index' do
    context 'There are some hunts' do
      before { create_list(:hunt, 7, hunt_items: create_list(:hunt_item, 3)) }

      it 'should return a formatted list of hunts' do
        get :index, format: :json
        expect(JSON.parse(response.body)['hunts'].count).to eq 7
      end

      context 'pagination parameters has been sent' do
        before { get :index, per_page: 1, page: 2, format: :json }

        it 'should return only one hunt' do
          expect(JSON.parse(response.body)['hunts'].count).to eq 1
        end

        it "should have the hunts count as number of pages as it's one per page" do
          expect(JSON.parse(response.body)['meta']['pages']).to eq 7
        end
      end
    end

    context 'There are no hunts' do
      it 'should return a payload with empty hunts' do
        get :index, format: :json
        expect(JSON.parse(response.body)['hunts']).to be_empty
      end

      it 'should have the meta attributes set to zero' do
        get :index, format: :json
        expect(JSON.parse(response.body)['meta']['pages']).to eq(0)
        expect(JSON.parse(response.body)['meta']['total']).to eq(0)
      end
    end
  end

  describe '#POST create' do
    let!(:hunt_params) do
      {
        'image' => {
          'filename' => 'katus.jpg',
          'type' => 'image/jpeg',
          'data' => 'data:image/jpeg;base64,/9j/4gv4SUtukxP/9k=',
          'size' => 108020
        },
        'image_url' => nil,
        'user_id' => nil,
        'hunt_items' => [{
          'top' => 68.56187290969899,
          'left' => 68.89632107023411,
        }]
      }
    end

    before { post :create, format: :json, hunt: hunt_params }

    context 'everything went perfectly' do
      it 'should return the newly created hunt' do
        expect(response.status).to eq 201
      end
    end

    context 'there were an error in the process' do
      let!(:hunt_params) do
        {
          'image_url' => nil,
          'user_id' => nil,
          'hunt_items' => [{
            'top' => 68.56187290969899,
            'left' => 68.89632107023411,
          }]
        }
      end

      it 'should respond with a 422 status code' do
        expect(response.status).to eq 422
      end

      context 'it concerns a missing image' do
        it 'should return an error' do
          expect(JSON.parse(response.body)['errors']['image']).to eq [{
            'error' => 'blank'
          }]
        end
      end

      context 'it concerns the hunt items' do
        let!(:hunt_params) do
          {
            'image' => {
              'filename' => 'katus.jpg',
              'type' => 'image/jpeg',
              'data' => 'data:image/jpeg;base64,/9j/4gv4SUtukxP/9k=',
              'size' => 108020
            },
            'image_url' => nil,
            'user_id' => nil,
            'hunt_items' => []
          }
        end

        context 'missing hunt_items' do
          it 'should embbed the error in the hunt errors' do
            expect(JSON.parse(response.body)['errors']['hunt_items']).to eq [{
              'error' => 'too_short',
              'count' => 1
            }]
          end
        end

        context 'an error concerning a hunt item itself' do
          let!(:hunt_params) do
            {
              'image' => {
                'filename' => 'katus.jpg',
                'type' => 'image/jpeg',
                'data' => 'data:image/jpeg;base64,/9j/4gv4SUtukxP/9k=',
                'size' => 108020
              },
              'image_url' => nil,
              'user_id' => nil,
              'hunt_items' => [{
                'top' => 68.56187290969899,
              }]
            }
          end

          it 'should embedd the lower error in the hunt errors' do
            expect(JSON.parse(response.body)['errors']).to eq({
              'hunt_items.left' => [{
                'error' => 'blank'
              }]
            })
          end
        end
      end
    end
  end
end
