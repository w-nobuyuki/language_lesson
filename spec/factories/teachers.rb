FactoryBot.define do
  factory :teacher do
    name { 'Teacher' }
    email { 'teacher@tryout.com' }
    password { 'password' }
  end

  factory :teacher2, class: Teacher do
    name { 'Teacher2' }
    email { 'teacher2@tryout.com' }
    password { 'password' }
  end
end
