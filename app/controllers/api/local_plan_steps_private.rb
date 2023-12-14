# = LocalPlanStepsPrivate
#
# Module containing private methods for handling local plan steps.

module LocalPlanStepsPrivate
  private

  # find_local_plan_steps method
  #
  # This method retrieves local plan steps based on the provided robot_id and orders them by stepNumber.
  #
  # Parameters:
  #   None (uses params[:robot_id])
  #
  # Returns a collection of local plan steps ordered by stepNumber.
  def find_local_plan_steps
    LocalPlanStep.where(robot_id: params[:robot_id]).order(:stepNumber)
  end

  # create_or_update_local_plan_step method
  #
  # This method creates or updates a local plan step using parameters and returns the updated/created step.
  #
  # Parameters:
  #   None (uses local_plan_step_params)
  #
  # Returns the created or updated local plan step.
  def create_or_update_local_plan_step
    step = find_or_initialize_local_plan_step
    step.update!(local_plan_step_params)
    step
  end

  # find_or_initialize_local_plan_step method
  #
  # This method finds an existing local plan step by id or initializes a new one.
  #
  # Parameters:
  #   None (uses params[:id])
  #
  # Returns the found or initialized local plan step.
  def find_or_initialize_local_plan_step
    LocalPlanStep.find_by(id: params[:id]) || LocalPlanStep.new
  end

  # delete_local_plan_step method
  #
  # This method finds and deletes a local plan step by id.
  #
  # Parameters:
  #   None (uses params[:id])
  #
  # Returns the deleted local plan step.
  def delete_local_plan_step
    step = LocalPlanStep.find(params[:id])
    step.destroy
    step
  end

  # local_plan_step_params method
  #
  # This method permits and merges parameters for a local plan step, including additional skill parameters resolved dynamically.
  #
  # Parameters:
  #   None (uses params[:local_plan_step] and SkillParametersResolver.resolve)
  #
  # Returns permitted and merged parameters for a local plan step.
  def local_plan_step_params
    params.require(:local_plan_step).permit(:skill, :label, :stepNumber, :robot_id)
          .merge(SkillParametersResolver.resolve(params[:skill]))
  end

  # render_error method
  #
  # This method renders an error message as JSON with a specified status.
  #
  # Parameters:
  #   message - Error message to be rendered.
  #   status - HTTP status code for the error.
  #
  # Renders a JSON response containing the provided error message and status.
  def render_error(message, status)
    render json: { message: message }, status: status
  end
end
