require 'rails_helper'

RSpec.describe 'Breeds API', type: :request do

  let!(:breeds) { create_list(:breed, 20) }
  let(:breed_id) { breeds.first.id }
  let!(:tags) { create_list(:tag, 20).map { |e| e.name } }

  describe 'GET /breeds' do
    before { get '/breeds' }

    it 'returns breeds' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns 200 response' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /breeds/:id' do
    before { get "/breeds/#{breed_id}"}

    context 'when breed exists' do
      it 'returns breed' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(breed_id)
      end

      it 'returns 200 response' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when breed does not exist' do
      let(:breed_id) { 200 }

      it 'returns 404 response' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Breed/)
      end
    end
  end

  describe 'POST /breeds' do
    let(:valid_params) { { name: 'Tabby' } }

    context 'create request if valid' do
      before { post '/breeds', params: valid_params }

      it 'creates a breed' do
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Tabby')
      end

      it 'returns 201 response' do
        expect(response).to have_http_status(201)
      end
    end

    context 'create request is invalid' do
      before { post '/breeds', params: {} }

      it 'returns 400 response' do
        expect(response).to have_http_status(400)
      end

      it 'returns validation error message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PATCH /breeds' do
    let(:valid_params) { { id: breed_id, name: "Siamese" } }

    before { patch "/breeds/#{breed_id}", params: valid_params}

    it 'returns 204 response' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE /breeds/:id' do
    context 'delete contains unknown id' do
      before { delete '/breeds/9000' }

      it 'returns 404 response' do
        expect(response).to have_http_status(404)
      end
    end

    context 'delete contains known id' do
      before { delete "/breeds/#{breed_id}" }

      it 'returns 204 response' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'POST /breeds/:id/tags' do
    context 'request contains unknown id' do
      before { post "/breeds/#{breed_id}/tags", params: { id: breed_id, tags: tags } }
      it 'updates breed' do
        json = JSON.parse(response.body)
        expect(json['tags']).not_to be_empty
      end
    end
  end
end
