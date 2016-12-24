class CreateMemberTodoItems < ActiveRecord::Migration
  def change
    create_table :member_todo_items do |t|

      t.timestamps null: false
    end
  end
end
