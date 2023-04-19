require 'rails_helper'

RSpec.describe 'Subscription Requests API', type: :request do
  describe 'POST /api/v1/subscription_requests' do
    let!(:customer) { create(:customer) }
    let!(:tea) { create(:tea) }

    describe 'Happy Path' do
      it 'creates a subscription' do
        subscription_params = {
          title: Faker::Sports::Basketball.team,
          price: Faker::Number.decimal(l_digits: 2),
          status: 1,
          frequency: Faker::Number.between(from: 0, to: 2),
          tea_id: tea.id,
          customer_id: customer.id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_params)
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)
      end
    end
  end
end