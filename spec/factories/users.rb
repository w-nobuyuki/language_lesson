FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'user@tryout.com' }
    password { 'password' }
  end

  factory :user2, class: User do
    name { 'user2' }
    email { 'user2@tryout.com' }
    password { 'password' }
  end
end
