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
    local_plan_steps = params.require(:local_plan)
    robot_id = params.require(:robot_Id)
    created_steps = []
  
    LocalPlanStep.transaction do
      local_plan_steps.each_with_index do |step_params, index|
        step_params[:stepNumber] = index + 1
        step_params[:robot_id] = robot_id
        step = LocalPlanStep.new(local_plan_step_create_params(step_params))
        step.save!
        created_steps << step
      end
    end
  
    render json: created_steps, status: :ok
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

  def local_plan_step_create_params(step_params)
    skill = step_params[:skill]
  
    case skill
    when 'navigation'
      parameter_content = { parameter: [:room, waypoints: [:x, :y, :z]] }
    when 'approach_person', 'authenticate_person', 'send_message', 'wait_message', 'approach_robot'
      parameter_content = { parameter: [:topic] }
    when 'operate_drawer'
      parameter_content = { parameter: [:action] }
    else
      return step_params.permit(:label, :stepNumber, :robot_id)
    end
    
    step_params.permit(:skill, :label, :stepNumber, :robot_id, parameter_content)
  end

  def local_plan_step_update_params
    par = params.require(:local_plan_step)
    skill = par[:skill]

    case skill
    when 'navigation'
      parameter_content = [:room, waypoints: [:x, :y, :z]]
    when 'approach_person', 'authenticate_person', 'send_message', 'wait_message', 'approach_robot'
      parameter_content = [:topic]
    when 'operate_drawer'
      parameter_content = [:action]
    else
      # dont permit skill:
      return par.permit(:label, :robot_id)
    end

    par.permit(:skill, :label, :robot_id, parameter: parameter_content)
  end
end
