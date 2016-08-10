class V1::BreakPointsController < V1::BaseController
  before_action :set_break_point, only: [:show, :update, :destroy]

  def index
    break_points = BreakPoint.all
    render json: break_points, status: 200, each_serializer: V1::BreakPointSerializer
  end

  def show
    render json: @break_point, status: 200, serializer: V1::BreakPointSerializer
  end

  def create
    break_point = BreakPoint.new(break_point_params)

    if break_point.save
      render json: break_point, status: 201, serializer: V1::BreakPointSerializer
    else
      render json: break_point.errors, status: 422
    end
  end

  def update
    if @break_point.update(break_point_params)
      render json: @break_point, status: 201, serializer: V1::BreakPointSerializer
    else
      render json: @break_point.errors, status: 422
    end
  end

  def destroy
    @break_point.destroy
    render status: 204
  end

  private

  def set_break_point
    @break_point ||= BreakPoint.find(params[:id])
  end

  def break_point_params
    params.require(:break_point).permit(:worker_id, :micro_task_id, :opened)
  end
end
