module LocalPlanStepsPrivate
  private

  def find_local_plan_steps
    LocalPlanStep.where(robot_id: params[:robot_id]).order(:stepNumber)
  end

  def create_or_update_local_plan_step
    step = find_or_initialize_local_plan_step
    step.update!(local_plan_step_params)
    step
  end

  def find_or_initialize_local_plan_step
    LocalPlanStep.find_by(id: params[:id]) || LocalPlanStep.new
  end

  def delete_local_plan_step
    step = LocalPlanStep.find(params[:id])
    step.destroy
    step
  end

  def local_plan_step_params
    params.require(:local_plan_step).permit(:skill, :label, :stepNumber, :robot_id)
      .merge(SkillParametersResolver.resolve(params[:skill]))
  end

  def render_error(message, status)
    render json: { message: message }, status: status
  end
end
