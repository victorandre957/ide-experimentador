class CreateTrials < ActiveRecord::Migration[7.1]
  def change
    create_table :trials do |t|
      t.string :name
      t.boolean :disabled
      t.boolean :deleted
      t.integer :runs
      t.belongs_to :experiment
      t.timestamps
    end
  end
end
