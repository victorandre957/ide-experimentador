class CreateTrialExecutions < ActiveRecord::Migration[7.1]
  def change
    create_table :trial_executions do |t|
      t.string :status
      t.text :log
      t.belongs_to :trial
      
      t.timestamps
    end
  end
end
