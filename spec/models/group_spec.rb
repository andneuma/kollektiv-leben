describe Group do
  let(:group) { create :group }
  subject { group }


  it 'should have 2 registration tokens after create' do
    expect(group.registration_tokens.count).to eq(2)
  end
end
