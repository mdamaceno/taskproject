require 'rails_helper'

RSpec.describe Worker, type: :request do
  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    it 'retrieves a list of workers' do
      create_list(:worker, 10)
      get '/v1/workers', as: :json
      expect(response.status).to eq(200)
      expect(json.length).to eq 10
    end
  end

  describe '#show' do
    it 'retrieves a worker' do
      worker = create(:worker)
      get "/v1/workers/#{worker.id}", as: :json
      expect(response.status).to eq(200)
      expect(json['name']).to eq worker.name
    end
  end

  describe '#create' do
    before do
      @worker = build(:worker)
    end

    it 'returns status 201' do
      post '/v1/workers', params: @worker, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'saves a new worker' do
        expect do
          post '/v1/workers', params: { worker: @worker }, as: :json
        end.to change(Worker, :count).by(1)
        expect(json['name']).to eq @worker.name
        expect(json['email']).to eq @worker.email
      end
    end

    context 'with invalid params' do
      it 'returns status 422' do
        worker = build(:worker, name: nil)
        post '/v1/workers', params: worker, as: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    before do
      @worker = create(:worker, name: 'Marco')
    end

    it 'returns status 201' do
      patch "/v1/workers/#{@worker.id}", params: { worker: { name: 'Antônio' } }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'updates a worker' do
        patch "/v1/workers/#{@worker.id}", params: { worker: { name: 'Antônio' } }, as: :json
        expect(json['name']).to_not eq 'Marco'
        expect(json['name']).to eq 'Antônio'
      end
    end

    context 'with invalid params' do
      it 'return status 422' do
        patch "/v1/workers/#{@worker.id}", params: { worker: { name: nil } }, as: :json
        expect(response.status).to eq(422)
        expect(Worker.find(@worker.id).name).to eq 'Marco'
      end
    end
  end

  describe '#destroy' do
    before do
      @worker = create(:worker)
    end

    it 'deletes a worker' do
      expect do
        delete "/v1/workers/#{@worker.id}", as: :json
      end.to change(Worker, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
