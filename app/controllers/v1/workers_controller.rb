class V1::WorkersController < V1::BaseController
  before_action :set_worker, only: [:show, :update, :destroy]

  def index
    workers = Worker.all
    render json: workers, status: 200, each_serializer: V1::WorkerSerializer
  end

  def show
    render json: @worker, status: 200, serializer: V1::WorkerSerializer
  end

  def create
    worker = Worker.new(worker_params)

    if worker.save
      render json: worker, status: 201, serializer: V1::WorkerSerializer
    else
      render json: worker.errors, status: 422
    end
  end

  def update
    if @worker.update(worker_params)
      render json: @worker, status: 201, serializer: V1::WorkerSerializer
    else
      render json: @worker.errors, status: 422
    end
  end

  def destroy
    @worker.destroy
    render status: 204
  end

  private

  def set_worker
    @worker ||= Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:name, :email, :password, :role, :status)
  end
end
