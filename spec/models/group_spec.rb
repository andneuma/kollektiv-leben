describe Group do
  let(:group) { create :group }
  subject { group }

  # Callback tests
  it 'should have 2 registration tokens after create' do
    expect(group.registration_tokens.count).to eq(2)
  end

  # Associations
  context 'associations' do
    it { should have_many(:todo_lists) }
    it { should have_many(:todo_items) }
    it { should have_many(:members) }
  end

  # Class methods
  it 'can generate a password reset token and digest' do
    group.generate_password_reset_digest
    expect(group.password_reset_token).to be_a(String)
    expect(group.password_reset_digest).to be_a(String)
  end

  # Validations
  it { should have_secure_password }

  it 'should not accept a mal-formatted email address if supplied' do
    group.email = 'foo@bar'
    expect(group).to_not be_valid
  end

  it 'need not to have an email address' do
    group.email = nil
    expect(group).to be_valid
  end

  context 'name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name) }
  end
end
