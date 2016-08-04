require 'rails_helper'

RSpec.describe 'Project requests', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:projects) { create_list(:project, 5) }

  describe '#index' do
    before do
      get '/v1/projects', as: :json
    end

    it 'get response status 200' do
      expect(response.status).to eq(200)
    end

    # it "retrieves a list of projects" do
    #   expect(json.collect{|l| l["title"]}).to include
    # end
  end
  it 'retrieves a specific project'
  it 'saves a new project'
  it 'updates a project'
  it 'deletes a project'
end
