require 'rails_helper'

RSpec.describe MicroTask, type: :request do
  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    it 'retrieves a list of micro tasks' do
      create_list(:micro_task, 10)
      get '/v1/micro_tasks', as: :json
      expect(response.status).to eq(200)
      expect(json.length).to eq 10
    end
  end

  describe '#show' do
    it 'retrieves a micro_task' do
      micro_task = create(:micro_task)
      get "/v1/micro_tasks/#{micro_task.id}", as: :json
      expect(response.status).to eq(200)
      expect(json['title']).to eq micro_task.title
    end
  end

  describe '#create' do
    before do
      @micro_task = build(:micro_task)
    end

    it 'returns status 201' do
      post '/v1/micro_tasks', params: @micro_task, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'saves a new micro_task' do
        expect do
          post '/v1/micro_tasks', params: { micro_task: @micro_task }, as: :json
        end.to change(MicroTask, :count).by(1)
        expect(json['title']).to eq @micro_task.title
        expect(json['notes']).to eq @micro_task.notes
        expect(json['level']).to eq @micro_task.level
      end
    end

    context 'with invalid params' do
      it 'returns status 422' do
        micro_task = build(:micro_task, title: nil)
        post '/v1/micro_tasks', params: micro_task, as: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    before do
      @micro_task = create(:micro_task, title: 'Usual')
    end

    it 'returns status 201' do
      patch "/v1/micro_tasks/#{@micro_task.id}", params: { micro_task: { title: 'Special' } }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'updates a micro_task' do
        patch "/v1/micro_tasks/#{@micro_task.id}", params: { micro_task: { title: 'Special' } }, as: :json
        expect(json['title']).to_not eq 'Usual'
        expect(json['title']).to eq 'Special'
      end
    end

    context 'with invalid params' do
      it 'return status 422' do
        patch "/v1/micro_tasks/#{@micro_task.id}", params: { micro_task: { title: nil } }, as: :json
        expect(response.status).to eq(422)
        expect(MicroTask.find(@micro_task.id).title).to eq 'Usual'
      end
    end
  end

  describe '#destroy' do
    before do
      @micro_task = create(:micro_task)
    end

    it 'deletes a micro_task' do
      expect do
        delete "/v1/micro_tasks/#{@micro_task.id}", as: :json
      end.to change(MicroTask, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
