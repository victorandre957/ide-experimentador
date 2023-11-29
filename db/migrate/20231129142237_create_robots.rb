class CreateRobots < ActiveRecord::Migration[7.1]
  def change
    create_table :robots do |t|

      t.timestamps
    end
  end
end
