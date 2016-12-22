FactoryGirl.define do
  factory :group do
    name 'SomeTestGroup'
    email 'foo@bar.org'
    password_digest BCrypt::Password.create("secret")
  end
end
