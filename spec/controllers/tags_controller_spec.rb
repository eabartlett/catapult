require 'rails_helper'

RSpec.describe 'Tags API', type: :request do

  let!(:tags) { create_list(:tag, 20) }
  let(:tag_id) { tags.first.id }

  describe 'GET /tags' do
    before { get '/tags' }

    it 'returns breeds' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns 200 reponse' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /tags/:id' do
    before { get "/tags/#{tag_id}" }

    context 'when tag exists' do
      it 'returns tag' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(tag_id)
      end

      it 'returns 200 response' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when tag does not exist' do
      let(:tag_id) { 200 }

      it 'returns 404 response' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Tag/)
      end
    end

    describe 'PATCH /tags/:id' do
      let(:valid_params) { { id: tag_id, name: 'valid tag name'} }
      context 'when given valid params' do
        before { patch "/tags/#{tag_id}", params: valid_params }

        it 'returns 204 response' do
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'DELETE /tags/:id' do
      context 'delete contains unknown id' do
        before { delete '/tags/90210' }

        it 'returns 404 response' do
          expect(response).to have_http_status(404)
        end
      end

      context 'delete contains known id' do
        before { delete "/tags/#{tag_id}" }

        it 'returns 204 response' do
          expect(response).to have_http_status(204)
        end
      end
    end
  end

end
