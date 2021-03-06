require 'rails_helper'

RSpec.describe BreakPoint, type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:worker) { create(:worker) }
  let(:project) { create(:project) }
  let(:macro_task) { create(:macro_task, worker: worker) }
  let(:micro_task) { create(:micro_task, macro_task: macro_task) }

  describe '#index' do
    it 'retrieves a list of break_points' do
      create_list(:break_point, 10, worker: worker, micro_task: micro_task)
      get '/v1/break_points', as: :json
      expect(response.status).to eq(200)
      expect(json.length).to eq 10
    end
  end

  describe '#show' do
    it 'retrieves a break_point' do
      break_point = create(:break_point, worker: worker, micro_task: micro_task)
      get "/v1/break_points/#{break_point.id}", as: :json
      expect(response.status).to eq(200)
      expect(json['worker_id']).to eq break_point.worker_id
      expect(json['micro_task_id']).to eq break_point.micro_task_id
      expect(json['opened']).to eq break_point.opened
    end
  end

  describe '#create' do
    before do
      @break_point = attributes_for(:break_point, opened: 0, worker_id: worker.id, micro_task_id: micro_task.id)
    end

    it 'returns status 201' do
      post '/v1/break_points', params: { break_point: @break_point }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'saves a new break_point' do
        expect do
          post '/v1/break_points', params: { break_point: @break_point }, as: :json
        end.to change(BreakPoint, :count).by(1)
        expect(json['worker_id']).to eq worker.id
        expect(json['micro_task_id']).to eq micro_task.id
        expect(json['opened']).to eq 0
      end
    end

    context 'with invalid params' do
      it 'returns status 422' do
        break_point = build(:break_point)
        post '/v1/break_points', params: break_point, as: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    before do
      @break_point = create(:break_point, opened: 0, worker: worker, micro_task: micro_task)
    end

    it 'returns status 201' do
      patch "/v1/break_points/#{@break_point.id}", params: { break_point: { opened: 1 } }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'updates a break_point' do
        patch "/v1/break_points/#{@break_point.id}", params: { break_point: { opened: 1 } }, as: :json
        expect(json['opened']).to_not eq 0
        expect(json['opened']).to eq 1
      end
    end

    context 'with invalid params' do
      it 'return status 422' do
        patch "/v1/break_points/#{@break_point.id}", params: { break_point: { opened: nil } }, as: :json
        expect(response.status).to eq(422)
        expect(BreakPoint.find(@break_point.id).opened).to eq 0
      end
    end
  end

  describe '#destroy' do
    before do
      @break_point = create(:break_point, worker: worker, micro_task: micro_task)
    end

    it 'deletes a break_point' do
      expect do
        delete "/v1/break_points/#{@break_point.id}", as: :json
      end.to change(BreakPoint, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
