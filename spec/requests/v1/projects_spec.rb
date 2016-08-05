require 'rails_helper'

RSpec.describe Project, type: :request do
  let(:json) { JSON.parse(response.body) }
  # let(:projects) { create(:project) }

  describe '#index' do
    it 'retrieves a list of projects' do
      create_list(:project, 10)
      get '/v1/projects', as: :json
      expect(response.status).to eq(200)
      expect(json.length).to eq 10
    end
  end

  describe '#show' do
    it 'retrieves a project' do
      project = create(:project)
      get "/v1/projects/#{project.id}", as: :json
      expect(response.status).to eq(200)
      expect(json['title']).to eq project.title
    end
  end

  describe '#create' do
    before do
      @project = build(:project)
    end

    it 'returns status 201' do
      post '/v1/projects', params: @project, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'saves a new project' do
        expect do
          post '/v1/projects', params: { project: @project }, as: :json
        end.to change(Project, :count).by(1)
        expect(json['title']).to eq @project.title
        expect(json['notes']).to eq @project.notes
      end
    end

    context 'with invalid params' do
      it 'returns status 422' do
        project = build(:project, title: nil)
        post '/v1/projects', params: project, as: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    before do
      @project = create(:project, title: 'Usual')
    end

    it 'returns status 201' do
      patch "/v1/projects/#{@project.id}", params: { project: { title: 'Special' } }, as: :json
      expect(response.status).to eq(201)
    end

    context 'with valid params' do
      it 'updates a project' do
        patch "/v1/projects/#{@project.id}", params: { project: { title: 'Special' } }, as: :json
        expect(json['title']).to_not eq 'Usual'
        expect(json['title']).to eq 'Special'
      end
    end

    context 'with invalid params' do
      it 'return status 422' do
        patch "/v1/projects/#{@project.id}", params: { project: { title: nil } }, as: :json
        expect(response.status).to eq(422)
        expect(Project.find(@project.id).title).to eq 'Usual'
      end
    end
  end

  describe '#destroy' do
    before do
      @project = create(:project)
    end

    it 'deletes a project' do
      expect do
        delete "/v1/projects/#{@project.id}", as: :json
      end.to change(Project, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
