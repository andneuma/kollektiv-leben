class AddGroupToTodoLists < ActiveRecord::Migration
  def change
    add_reference :todo_lists, :group, index: true, foreign_key: true
  end
end
