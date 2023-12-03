class AddSkillToLocalPlanStep < ActiveRecord::Migration[7.1]
  def change
    add_column :local_plan_steps, :skill, :string
  end
end
