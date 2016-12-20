describe TodoItem do
  it 'should be invalid if empty' do
    expect(TodoItem.new).to be_invalid
  end

  let(:todo_list) { TodoList.new(name: 'TestTodoList') }
  let(:todo_item) { TodoItem.new(name: 'TestTodo', description: 'Something todo', start_date: Date.today, end_date: Date.today + 1.days, completed: false) }
  subject { todo_item }

  it 'should not be valid if start date is behind end date' do
    todo_item.end_date = Date.today - 1 
    expect(todo_item).to be_invalid
  end

  it 'should not be valid if name is too short' do
    todo_item.name = "a"
    expect(todo_item).to be_invalid
  end

  it 'should not be valid if name is too long' do
    todo_item.name = "a"*41
    expect(todo_item).to be_invalid
  end
end
