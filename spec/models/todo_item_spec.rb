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

  # Validations
  it { should validate_length_of(:name) }

  context 'should be invalid' do
    it 'if start date is behind end date' do
      todo_item.end_date = Date.today - 1 
      expect(todo_item).to be_invalid
    end
  end

  # Associations
  context 'associations' do
    it { should belong_to(:todo_list) }

    it 'should become destroyed if parent todolist becomes destroyed' do
      todo_item.todo_list.destroy!
      expect(TodoItem.all).not_to include todo_item
    end

    it { should have_many(:members) }
  end
end
