describe Group do
  let(:group) { create :group }
  subject { group }


  it 'should have 2 registration tokens after create' do
    expect(group.registration_tokens.count).to eq(2)
  end

  it 'should not accept a mal-formatted email address if supplied' do
    group.email = 'foo@bar'
    expect(group).to_not be_valid
  end

  it 'need not to have an email address' do
    group.email = nil
    expect(group).to be_valid
  end

  context 'name' do
    it 'should be present' do
      group.name = nil
      expect(group).to be_invalid
    end

    it 'should be longer than 2 characters' do
      group.name = "AA"
      expect(group).to be_invalid
    end

    it 'should not be longer than 40 characters' do
      group.name = "A"*41
      expect(group).to be_invalid
    end
  end

  it 'can generate a password reset token and digest' do
    group.generate_password_reset_digest
    expect(group.password_reset_token).to be_a(String)
    expect(group.password_reset_digest).to be_a(String)
  end
end
