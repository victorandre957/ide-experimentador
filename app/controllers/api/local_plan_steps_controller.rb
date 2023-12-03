class Api::LocalPlanStepsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index_by_robot
    robot_id = params[:robot_id]

    steps = LocalPlanStep
      .where(robot_id: robot_id)
      .order(:stepNumber)

    render json: steps, status: :ok
  end

  def create
    # ignore rails csrf token
    p create_params[:stepNumber]
  end

  def update
  end

  def delete
  end

  private

  def create_params
    par = params.require(:local_plan_step).permit(:skill, :label, :stepNumber)
    
    par[:parameter] = params[:parameter]

    par
  end

end
