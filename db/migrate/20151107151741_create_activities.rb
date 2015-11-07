class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :what
      t.date :when
      t.integer :length
      t.timestamps null: false
    end
  end
end
