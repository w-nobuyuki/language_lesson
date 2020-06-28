FactoryBot.define do
  factory :teacher do
    name { 'Teacher' }
    profile { '英語が得意です！よろしくお願いします！' }
    email { 'teacher@tryout.com' }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/resources/image.png')) }
    password { 'password' }
  end

  factory :teacher2, class: Teacher do
    name { 'Teacher2' }
    email { 'teacher2@tryout.com' }
    password { 'password' }
  end
end
