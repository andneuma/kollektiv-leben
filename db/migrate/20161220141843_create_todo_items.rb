class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
