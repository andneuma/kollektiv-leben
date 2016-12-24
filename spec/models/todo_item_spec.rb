describe TodoItem do
  it 'should be invalid if empty' do
    expect(TodoItem.new).to be_invalid
  end

  let(:todo_list) { create(:todo_list) }
  let(:todo_item) { create(:todo_item) }
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
    new_todo = todo_list.todo_items.create(name: 'AnotherTestTodo', description: 'Something todo', start_date: Date.today, end_date: Date.today + 1.days)
    expect(todo_list.todo_items).to include new_todo
  end

  it 'should become destroyed if parent todolist becomes destroyed' do
    todo_item.todo_list.destroy!
    expect(TodoItem.all).not_to include todo_item
  end

  context 'associations' do
    it { should belong_to(:todo_list) }
    it { should have_and_belong_to_many(:members) }
  end
end
