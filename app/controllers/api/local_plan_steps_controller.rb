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
        step = LocalPlanStep.new(local_plan_step_params(step_params))
        step.save!
        created_steps << step
      end
    end
  
    render json: created_steps, status: :ok
  rescue ActionController::ParameterMissing => e
    render json: { message: e.message }, status: 422
  rescue ActiveRecord::RecordInvalid => e
    render json: { message: e.message }, status: 422
  end

  def update
    robot_id = params.require(:robot_Id)
    local_plan_steps = params.require(:local_plan)

    LocalPlanStep.transaction do
      # Delete steps not present in the updated list for the given robot
      LocalPlanStep.where(robot_id: robot_id).where.not(id: local_plan_steps.pluck(:id)).destroy_all

      local_plan_steps.each_with_index do |step_params, index|
        step_params[:stepNumber] = index + 1
        step_params[:robot_id] = robot_id

        step = LocalPlanStep.find_or_initialize_by(id: step_params[:id], robot_id: robot_id)
        step.assign_attributes(local_plan_step_params(step_params))
        step.save!
      end
    end

    render json: { message: "Updated all steps associated with robot ID #{robot_id}" }, status: :ok
    rescue ActionController::ParameterMissing => e
      render json: { message: e.message }, status: 400
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: e.message }, status: 422
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: e.message }, status: 404
  end

  def delete
    robot_id = params[:robot_id]
    deleted_steps = LocalPlanStep.where(robot_id: robot_id).destroy_all
    render json: { message: "Deleted all steps associated with robot ID #{robot_id}" }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  def delete_step
    if (params[:id])
      render json: LocalPlanStep.destroy(params[:id]), status: :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end
  
  private

  def local_plan_step_params(step_params)
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
end
