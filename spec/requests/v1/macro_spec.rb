require 'rails_helper'

RSpec.describe MacroTask, type: :request do
  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    it 'retrieves a list of macro tasks' do
      create_list(:macro_task, 10)
      get '/v1/macro_tasks', as: :json
      expect(response.status).to eq(200)
      expect(json.length).to eq 10
    end
  end

  describe '#show' do
    it 'retrieves a macro_task' do
      macro_task = create(:macro_task)
      get "/v1/macro_tasks/#{macro_task.id}", as: :json
      expect(response.status).to eq(200)
      expect(json['title']).to eq macro_task.title
    end
  end

  describe '#create' do
    before do
      @macro_task = build(:macro_task)
    end

    it 'returns status 201' do
      post '/v1/macro_tasks', params: @macro_task, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'saves a new macro_task' do
        expect do
          post '/v1/macro_tasks', params: { macro_task: @macro_task }, as: :json
        end.to change(MacroTask, :count).by(1)
        expect(json['title']).to eq @macro_task.title
        expect(json['notes']).to eq @macro_task.notes
      end
    end

    context 'with invalid params' do
      it 'returns status 422' do
        macro_task = build(:macro_task, title: nil)
        post '/v1/macro_tasks', params: macro_task, as: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    before do
      @macro_task = create(:macro_task, title: 'Usual')
    end

    it 'returns status 201' do
      patch "/v1/macro_tasks/#{@macro_task.id}", params: { macro_task: { title: 'Special' } }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'updates a macro_task' do
        patch "/v1/macro_tasks/#{@macro_task.id}", params: { macro_task: { title: 'Special' } }, as: :json
        expect(json['title']).to_not eq 'Usual'
        expect(json['title']).to eq 'Special'
      end
    end

    context 'with invalid params' do
      it 'return status 422' do
        patch "/v1/macro_tasks/#{@macro_task.id}", params: { macro_task: { title: nil } }, as: :json
        expect(response.status).to eq(422)
        expect(MacroTask.find(@macro_task.id).title).to eq 'Usual'
      end
    end
  end

  describe '#destroy' do
    before do
      @macro_task = create(:macro_task)
    end

    it 'deletes a macro_task' do
      expect do
        delete "/v1/macro_tasks/#{@macro_task.id}", as: :json
      end.to change(MacroTask, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
