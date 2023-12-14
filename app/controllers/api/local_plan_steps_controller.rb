class Api::LocalPlanStepsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index_by_robot
    render json: LocalPlanStep.where(robot_id: params[:robot_id]).order(:stepNumber), status: :ok
  end

  def create
    step = LocalPlanStep.create!(local_plan_step_params)
    render json: step, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render_error(e.message, :unprocessable_entity)
  end

  def update
    step = LocalPlanStep.find(params[:id])
    step.update!(local_plan_step_params)
    render json: step, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render_error(e.message, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render_error(e.message, :unprocessable_entity)
  end

  def delete
    step = LocalPlanStep.find(params[:id])
    step.destroy
    render json: step, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render_error(e.message, :not_found)
  end

  private

  def local_plan_step_params
    permitted_params = params.require(:local_plan_step).permit(:skill, :label, :stepNumber, :robot_id)

    parameter_content = case permitted_params[:skill]
                        when 'navigation' then { parameter: [:room, waypoints: [:x, :y, :z]] }
                        when 'approach_person', 'authenticate_person', 'send_message', 'wait_message', 'approach_robot' then { parameter: [:topic] }
                        when 'operate_drawer' then { parameter: [:action] }
                        else {}
                        end

    permitted_params.merge(parameter_content)
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end
end
