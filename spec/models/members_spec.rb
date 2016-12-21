describe Member do
  let(:member) { build :member  }
  let(:group) { create :group }

  it 'should become deleted if parent group is deleted' do
    member = group.members.create attributes_for(:member)
    group.destroy
    expect(Member.all).not_to include(member)
  end

  context 'name' do
    it 'should have more than 2 characters' do
      member.name = "AA"
      expect(member).to be_invalid
    end

    it 'should not have more than 40 characters' do
      member.name = 'A'*41
      expect(member).to be_invalid
    end
  end
end
