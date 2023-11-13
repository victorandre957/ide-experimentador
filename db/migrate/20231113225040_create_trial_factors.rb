class CreateTrialFactors < ActiveRecord::Migration[7.1]
  def change
    create_table :trial_factors do |t|
      t.belongs_to :factor
      t.belongs_to :trial
      t.timestamps
    end
  end
end
