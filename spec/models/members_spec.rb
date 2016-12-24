describe Member do
  let(:member) { build :member  }
  let(:group) { create :group }

  it 'should become deleted if parent group is deleted' do
    member = group.members.create attributes_for(:member)
    group.destroy
    expect(Member.all).not_to include(member)
  end

  context 'associations' do
    it { should belong_to(:group) }
    it { should have_many(:todo_items) }
  end

  context 'name' do
    it { should validate_length_of(:name) }
  end
end
