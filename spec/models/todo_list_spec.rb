describe TodoList do
  let(:todo_list) { FactoryGirl.build :todo_list }
  subject { todo_list }

  # Associations
  context 'associations' do
    it { should belong_to(:group) }
    it { should have_many(:todo_items) }
  end

  # Validations
  it { should be_valid }
  it { should validate_length_of(:name) }

end
