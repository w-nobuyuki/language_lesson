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