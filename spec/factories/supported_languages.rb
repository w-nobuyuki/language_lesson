FactoryBot.define do
  factory :teacher_supported_english, class: SupportedLanguage do
    association :teacher
    association :language, factory: :english
  end

  factory :teacher_supported_chinese, class: SupportedLanguage do
    association :teacher
    association :language, factory: :chinese
  end
end
