module LocalPlanStepsIndex
  def index_by_robot
    render_local_plan_steps(find_local_plan_steps)
  end

  def render_local_steps(steps)
    render json: steps, status: :ok
  end
end
