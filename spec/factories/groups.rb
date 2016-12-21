FactoryGirl.define do
  factory :group do
    name 'SomeTestGroup'
    email 'SomeTestEmail'
    password_digest BCrypt::Password.create("secret")
  end
end
