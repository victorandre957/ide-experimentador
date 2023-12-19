# Controller responsible for managing LocalPlanSteps associated with a Robot in the API.
class Api::LocalPlanStepsController < ApplicationController
  # Skips authenticity token verification for actions within this controller.
  skip_before_action :verify_authenticity_token

  # Retrieves all local plan steps associated with a specific robot, ordered by step number.
  #
  # GET /api/local_plan_steps/index_by_robot
  # @param params[:robot_id] [String] The ID of the robot to retrieve steps for.
  # @return [JSON] Returns a JSON response containing the retrieved steps.
  def index_by_robot
    # Extracts the robot_id from parameters
    robot_id = params[:robot_id]
    # Fetches steps associated with the given robot and orders them by step number
    steps = LocalPlanStep
      .where(robot_id: robot_id)
      .order(:stepNumber)
    # Renders the steps as JSON with a successful status
    render json: steps, status: :ok
  end
  # Creates local plan steps for a specific robot.
  #
  # POST /api/local_plan_steps/create
  # @param params[:local_plan] [Array<Hash>] Array of parameters for creating local plan steps.
  # @param params[:robot_Id] [String] The ID of the robot to associate the steps with.
  # @return [JSON] Returns a JSON response containing the created steps.
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
  
    render json: created_steps, status: :created
  rescue ActionController::ParameterMissing => e
    render json: { message: e.message }, status: 422
  rescue ActionRecord::RecordInvalid => e
    render json: {message: e.message}, status: 422
  end

  # Updates local plan steps associated with a specific robot.
  #
  # PUT /api/local_plan_steps/update
  # @param params[:local_plan] [Array<Hash>] Array of parameters for updating local plan steps.
  # @param params[:robot_Id] [String] The ID of the robot whose steps are being updated.
  # @return [JSON] Returns a JSON response indicating successful step updates.
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

  # Deletes all local plan steps associated with a specific robot.
  #
  # DELETE /api/local_plan_steps/delete
  # @param params[:robot_id] [String] The ID of the robot whose steps are to be deleted.
  # @return [JSON] Returns a JSON response indicating successful deletion of steps.
  def delete
    robot_id = params[:robot_id]
    deleted_steps = LocalPlanStep.where(robot_id: robot_id).destroy_all
    render json: { message: "Deleted all steps associated with robot ID #{robot_id}" }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  # Deletes a specific local plan step.
  #
  # DELETE /api/local_plan_steps/delete_step
  # @param params[:id] [String] The ID of the step to be deleted.
  # @return [JSON] Returns a JSON response indicating successful deletion of the step.
  
  def delete_step
    if (params[:id])
      render json: LocalPlanStep.destroy(params[:id]), status: :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end
  
  private

  # Defines permitted parameters for creating/updating local plan steps based on skill types.
  #
  # @param step_params [Hash] Parameters for a local plan step.
  # @return [ActionController::Parameters] Permitted parameters for creating/updating steps.
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
