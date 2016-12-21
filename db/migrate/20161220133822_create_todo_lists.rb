class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name
      t.text :description
      t.boolean :notifications_enabled

      t.timestamps null: false
    end
  end
end
