require 'rails_helper'

RSpec.describe 'Subscription Requests API', type: :request do
  describe 'POST Subscription Requests' do
    let!(:customer) { create(:customer) }
    let!(:tea) { create(:tea) }

    enum_status = ['inactive', 'active']
    enum_frequency = ['weekly', 'monthly', 'yearly']

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

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:data)
        expect(response_body[:data]).to be_a(Hash)
        expect(response_body[:data][:type]).to eq('subscription')
        expect(response_body[:data][:attributes][:title]).to eq(subscription_params[:title])
        expect(response_body[:data][:attributes][:price]).to eq(subscription_params[:price])
        expect(response_body[:data][:attributes][:status]).to eq(enum_status[subscription_params[:status]])
        expect(response_body[:data][:attributes][:frequency]).to eq(enum_frequency[subscription_params[:frequency]])

        subscription = Subscription.last

        expect(subscription.title).to eq(subscription_params[:title])
        expect(subscription.price).to eq(subscription_params[:price])
        expect(subscription.status).to eq(enum_status[subscription_params[:status]])
        expect(subscription.frequency).to eq(enum_frequency[subscription_params[:frequency]])
        expect(subscription.tea_id).to eq(subscription_params[:tea_id])
        expect(subscription.customer_id).to eq(subscription_params[:customer_id])
      end
    end

    describe 'Sad Path' do
      it 'returns an error if customer does not exist' do
        subscription_params = {
          title: Faker::Sports::Basketball.team,
          price: Faker::Number.decimal(l_digits: 2),
          status: 1,
          frequency: Faker::Number.between(from: 0, to: 2),
          tea_id: tea.id,
          customer_id: nil
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription_params)
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:errors)
        
        expect(response_body[:errors]).to be_an(Array)
        expect(response_body[:errors].first).to eq("Customer must exist")
      end
    end
  end

  describe 'PATCH Subscription Requests' do
    let!(:customer) { create(:customer) }
    let!(:tea) { create(:tea) }
    let!(:subscription) { create(:subscription, status: 1, customer_id: customer.id, tea_id: tea.id) }

    describe 'Happy Path' do
      it 'updates a subscription status' do
        subscription_params = {
          status: 0
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription_params)
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(response_body[:data][:attributes][:status]).to eq('inactive')

        subscription.reload

        expect(subscription.status).to eq('inactive')
      end
    end
  end
end