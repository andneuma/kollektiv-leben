describe TodoList do
  context 'Empty todolist' do
    it { should be_invalid }
  end

  context 'Todolist with name' do
    let(:todo_list) { FactoryGirl.build :todo_list }
    subject { todo_list }

    it { should be_valid }

    it 'should be invalid if name too short' do
      todo_list.name = 'a'
      expect(todo_list).to be_invalid
    end

    it 'should be invalid if name too long' do
      todo_list.name = 'a'*41
      expect(todo_list).to be_invalid
    end
  end
end
