describe TodoList do
  context 'Empty todolist' do
    it { should be_invalid }
  end

  context 'Todolist with name' do
    let(:todolist) { TodoList.new(name: 'SampleList') }
    subject { todolist }

    it { should be_valid }

    it 'should be invalid if name too short' do
      other_list = TodoList.new name: 'a'
      expect(other_list).to be_invalid
    end

    it 'should be invalid if name too long' do
      other_list = TodoList.new name: 'a'*41
      expect(other_list).to be_invalid
    end
  end
end
