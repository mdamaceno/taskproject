class V1::MacroTasksController < V1::BaseController
  before_action :set_macro_task, only: [:show, :update, :destroy]

  def index
    macro_tasks = MacroTask.all
    render json: macro_tasks, status: 200, each_serializer: V1::MacroTaskSerializer
  end

  def show
    render json: @macro_task, status: 200, serializer: V1::MacroTaskSerializer
  end

  def create
    macro_task = MacroTask.new(macro_task_params)

    if macro_task.save
      render json: macro_task, status: 201, serializer: V1::MacroTaskSerializer
    else
      render json: macro_task.errors, status: 422
    end
  end

  def update
    if @macro_task.update(macro_task_params)
      render json: @macro_task, status: 201, serializer: V1::MacroTaskSerializer
    else
      render json: @macro_task.errors, status: 422
    end
  end

  def destroy
    @macro_task.destroy
    render status: 204
  end

  private

  def set_macro_task
    @macro_task ||= MacroTask.find(params[:id])
  end

  def macro_task_params
    params.require(:macro_task).permit(:title, :notes, :created_by, :project_id)
  end
end
