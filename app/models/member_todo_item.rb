class MemberTodoItem < ActiveRecord::Base
  belongs_to :member
  belongs_to :todo_item
end
