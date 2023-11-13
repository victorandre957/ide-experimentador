class CreateClassifications < ActiveRecord::Migration[7.1]
  def change
    create_table :classifications do |t|
      t.belongs_to :trial
      t.belongs_to :tag
      t.timestamps
    end
  end
end
