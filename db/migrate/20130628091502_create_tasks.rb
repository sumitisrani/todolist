class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
