# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Language.exists?
  Language.create(name: '英語')
  Language.create(name: '中国語')
  Language.create(name: '韓国語')
  Language.create(name: 'スペイン語')
  Language.create(name: 'フランス語')
  Language.create(name: 'ドイツ語')
end

unless Admin.exists?
  Admin.create(email: 'admin@tryout.com', password: 'password')
end

unless Teacher.exists?
  teacher = Teacher.new(email: 'teacher@tryout.com', name: 'Teacher', password: 'password')
  teacher.supported_languages.build(language_id: 1)
  teacher.supported_languages.build(language_id: 2)
  teacher.supported_languages.build(language_id: 3)
  teacher.lessons.build(language_id: 1, start_at: Date.tomorrow.strftime('%Y/%m/%d 08:00:00'))
  teacher.lessons.build(language_id: 2, start_at: Date.tomorrow.strftime('%Y/%m/%d 10:00:00'))
  teacher.lessons.build(language_id: 2, start_at: Date.tomorrow.strftime('%Y/%m/%d 13:00:00'))
  teacher.save!
end

unless Item.exists?
  Item.create(name: 'レッスンチケット（1枚）', description: '外国語レッスン1回分のチケットです', amount: '2180', quantity: 1)
  Item.create(name: 'レッスンチケット（3枚）', description: '外国語レッスン3回分のチケットです', amount: '5400', quantity: 3)
  Item.create(name: 'レッスンチケット（5枚）', description: '外国語レッスン5回分のチケットです', amount: '8100', quantity: 5)
end

unless User.exists?
  user = User.create(name: 'user', email: 'user@tryout.com', password: 'password')
  charge = Charge.new(stripe_session_id: 'dummy', user: user, item: Item.first)
  3.times { charge.lesson_tickets.build }
  charge.save!
end
