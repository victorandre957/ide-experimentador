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
    render json: LocalPlanStep.create!(local_plan_step_create_params), status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { message: e.message }, status: 422
  end

  def update
    render json: LocalPlanStep.update!(params[:id], local_plan_step_update_params), status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { message: e.message }, status: 422
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  def delete
    render json: LocalPlanStep.destroy(params[:id]), status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  private

  def local_plan_step_create_params
    par = params.require(:local_plan_step)
    skill = par[:skill]

    case skill
    when 'navigation'
      parameter_content = [:room, waypoints: [:x, :y, :z]]
    when 'approach_person', 'authenticate_person', 'send_message', 'wait_message', 'approach_robot'
      parameter_content = [topic: []]
    when 'operate_drawer'
      parameter_content = [action: []]
    else
      # dont permit skill:
      return par.permit(:label, :stepNumber, :robot_id)
    end

    par.permit(:skill, :label, :stepNumber, :robot_id, parameter: parameter_content)
  end

  def local_plan_step_update_params
    par = params.require(:local_plan_step)
    skill = par[:skill]

    case skill
    when 'navigation'
      parameter_content = [:room, waypoints: [:x, :y, :z]]
    when 'approach_person', 'authenticate_person', 'send_message', 'wait_message', 'approach_robot'
      parameter_content = [topic: []]
    when 'operate_drawer'
      parameter_content = [action: []]
    else
      # dont permit skill:
      return par.permit(:label, :robot_id)
    end

    par.permit(:skill, :label, :robot_id, parameter: parameter_content)
  end
end
