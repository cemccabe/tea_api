require 'rails_helper'

RSpec.describe 'Customer Requests API', type: :request do
  describe 'POST Customer Requests' do
    it 'creates a customer' do
      customer_params = {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        address: Faker::Address.full_address
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/customers', headers: headers, params: JSON.generate(customer_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end
end