class V1::ProjectsController < V1::BaseController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    projects = Project.all
    render json: projects, status: 200
  end

  def show
    render json: @project, status: 200
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: project, status: 201
    else
      render json: project.errors, status: 422
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: 201
    else
      render json: @project.errors, status: 422
    end
  end

  def destroy
    @project.destroy
    render status: 204
  end

  private

  def set_project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :notes, :begin_at, :finish_at)
  end
end