require 'rails_helper'

RSpec.describe 'Tea Requests API', type: :request do
  describe 'POST Tea Requests' do
    it 'creates a tea' do
      tea_params = {
        title: Faker::Tea.variety,
        description: Faker::Coffee.notes,
        temperature: Faker::Number.between(from: 100.0, to: 150.0),
        brew_time: Faker::Number.number(digits: 2)
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/teas', headers: headers, params: JSON.generate(tea_params)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(response_body[:data][:attributes][:title]).to eq(tea_params[:title])
      expect(response_body[:data][:attributes][:description]).to eq(tea_params[:description])
      expect(response_body[:data][:attributes][:temperature]).to eq(tea_params[:temperature])
      expect(response_body[:data][:attributes][:brew_time]).to eq(tea_params[:brew_time])

      tea = Tea.last

      expect(tea.title).to eq(tea_params[:title])
      expect(tea.description).to eq(tea_params[:description])
      expect(tea.temperature).to eq(tea_params[:temperature])
      expect(tea.brew_time).to eq(tea_params[:brew_time])
    end
  end
end