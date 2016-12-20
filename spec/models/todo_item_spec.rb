describe TodoItem do
  it 'should be invalid if empty' do
    expect(TodoItem.new).to be_invalid
  end

  let(:todo_list) { TodoList.new(name: 'TestTodoList') }
  let(:todo_item) { TodoItem.new(name: 'TestTodo', description: 'Something todo', start_date: Date.today, end_date: Date.today + 1.days) }
  subject { todo_item }

  it 'should not be completed by default' do
    expect(todo_item.completed).to be false
  end

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

  it 'can references to parent todo list' do
    todo_list.save
    todo_list.todo_items.create(name: 'AnotherTestTodo', description: 'Something todo', start_date: Date.today, end_date: Date.today + 1.days)
    another_test_todo = TodoItem.find_by(name: 'AnotherTestTodo')
    expect(todo_list.todo_items).to include(another_test_todo)
  end

  it 'should become destroyed if parent todolist becomes destroyed' do
    todo_list.save
    todo_list.todo_items.create(name: 'AnotherTestTodo', description: 'Something todo', start_date: Date.today, end_date: Date.today + 1.days)
    another_test_todo = TodoItem.find_by(name: 'AnotherTestTodo')
    todo_list.destroy!
    expect(TodoItem.all).not_to include(another_test_todo)
  end
end
