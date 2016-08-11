class V1::MicroTasksController < V1::BaseController
  before_action :set_micro_task, only: [:show, :update, :destroy]

  def index
    micro_tasks = MicroTask.all
    render json: micro_tasks, status: 200, each_serializer: V1::MicroTaskSerializer
  end

  def show
    render json: @micro_task, status: 200, serializer: V1::MicroTaskSerializer
  end

  def create
    micro_task = MicroTask.new(micro_task_params)

    if micro_task.save
      render json: micro_task, status: 201, serializer: V1::MicroTaskSerializer
    else
      render json: micro_task.errors, status: 422
    end
  end

  def update
    if @micro_task.update(micro_task_params)
      render json: @micro_task, status: 201, serializer: V1::MicroTaskSerializer
    else
      render json: @micro_task.errors, status: 422
    end
  end

  def destroy
    @micro_task.destroy
    render status: 204
  end

  private

  def set_micro_task
    @micro_task ||= MicroTask.find(params[:id])
  end

  def micro_task_params
    params.require(:micro_task).permit(:title, :level, :notes, :macro_task_id)
  end
end
