class FixLocalPlanStepParametersName < ActiveRecord::Migration[7.1]
  def change
    rename_column :local_plan_steps, :parameters, :parameter
  end
end
