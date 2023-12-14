module LocalPlanStepsActions
  def create
    render_local_plan_step(create_or_update_local_plan_step)
  rescue ActiveRecord::RecordInvalid => e
    render_error(e.message, :unprocessable_entity)
  end

  def update
    render_local_plan_step(create_or_update_local_plan_step)
  end

  def delete
    render_local_plan_step(delete_local_plan_step)
  end

  def render_local_plan_step(step)
    render json: step, status: :ok
  end
end
