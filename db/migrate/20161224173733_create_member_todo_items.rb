class CreateMemberTodoItems < ActiveRecord::Migration
  def change
    create_table :member_todo_items do |t|
      t.references :member, index: true, foreign_key: true
      t.references :todo_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
