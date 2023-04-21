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
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(response_body[:data][:attributes][:first_name]).to eq(customer_params[:first_name])
      expect(response_body[:data][:attributes][:last_name]).to eq(customer_params[:last_name])
      expect(response_body[:data][:attributes][:email]).to eq(customer_params[:email])
      expect(response_body[:data][:attributes][:address]).to eq(customer_params[:address])

      customer = Customer.last

      expect(customer.first_name).to eq(customer_params[:first_name])
      expect(customer.last_name).to eq(customer_params[:last_name])
      expect(customer.email).to eq(customer_params[:email])
      expect(customer.address).to eq(customer_params[:address])
    end
  end
end