class V1::ProjectsController < V1::BaseController
  def index
    @projects = Project.all
    render json: @projects
  end
end
