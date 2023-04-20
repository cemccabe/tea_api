require 'rails_helper'

RSpec.describe 'Customer Subscriptions API', type: :request do
  describe 'GET customer subscriptions' do
    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:tea_1) { create(:tea) }
    let!(:tea_2) { create(:tea) }
    let!(:subscription_1) { create(:subscription, status: 1, customer_id: customer_1.id, tea_id: tea_1.id) }
    let!(:subscription_2) { create(:subscription, status: 0, customer_id: customer_1.id, tea_id: tea_2.id) }

    describe 'Happy Path' do
      it 'returns all subscriptions (active and inactive) for a customer' do
        get "/api/v1/customers/#{customer_1.id}/subscriptions"

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(response_body[:data].count).to eq(2)

        response_body[:data].each do |subscription|
          expect(subscription[:attributes][:customer_id]).to eq(customer_1.id)
        end
      end

      it 'returns an empty array if a customer has no subscriptions' do
        get "/api/v1/customers/#{customer_2.id}/subscriptions"

        response_body = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(response_body[:data]).to eq([])
      end
    end
  end
end