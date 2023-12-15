# = LocalPlanStepsActions
#
# Module containing actions related to local plan steps.

module LocalPlanStepsActions
  # create method
  #
  # This method handles the creation of a local plan step and renders the step as JSON.
  #
  # Parameters:
  #   None
  #
  # Renders the created local plan step as a JSON response.
  # Raises a :unprocessable_entity error if the record is invalid.
  def create
    render_local_plan_step(create_or_update_local_plan_step)
  rescue ActiveRecord::RecordInvalid => e
    render_error(e.message, :unprocessable_entity)
  end

  # update method
  #
  # This method handles the update of a local plan step and renders the updated step as JSON.
  #
  # Parameters:
  #   None
  #
  # Renders the updated local plan step as a JSON response.
  def update
    render_local_plan_step(create_or_update_local_plan_step)
  end

  # delete method
  #
  # This method handles the deletion of a local plan step and renders the deleted step as JSON.
  #
  # Parameters:
  #   None
  #
  # Renders the deleted local plan step as a JSON response.
  def delete
    render_local_plan_step(delete_local_plan_step)
  end

  # render_local_plan_step method
  #
  # This method renders a local plan step as JSON with a status of :ok.
  #
  # Parameters:
  #   step - The local plan step object to be rendered as JSON.
  #
  # Renders the provided local plan step as a JSON response with a status of :ok.
  def render_local_plan_step(step)
    render json: step, status: :ok
  end
end
