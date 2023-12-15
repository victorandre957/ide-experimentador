# = LocalPlanStepsIndex
#
# Module containing methods for indexing local plan steps.

module LocalPlanStepsIndex
  # index_by_robot method
  #
  # This method retrieves and renders local plan steps by robot as JSON.
  #
  # Parameters:
  #   None
  #
  # Renders the retrieved local plan steps by robot as a JSON response.
  def index_by_robot
    render_local_plan_steps(find_local_plan_steps)
  end

  # render_local_steps method
  #
  # This method renders local steps as JSON with a status of :ok.
  #
  # Parameters:
  #   steps - The collection of local plan steps to be rendered as JSON.
  #
  # Renders the provided collection of local plan steps as a JSON response with a status of :ok.
  def render_local_steps(steps)
    render json: steps, status: :ok
  end
end
