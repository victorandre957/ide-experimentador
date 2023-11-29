class CreateLocalPlanSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :local_plan_steps do |t|
      t.integer :stepNumber
      t.string :label
      t.json :parameters
      t.references :robot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
