class MarkNewTodoItemsIncompleteByDefault < ActiveRecord::Migration
  def change
    change_column :todo_items, :completed, :boolean, default: false
  end
end
