FactoryBot.define do
  factory :user do
    email {"testuser@gmail.com"}
    password {"test1234"}
    password_confirmation {password}
  end
end
