FactoryBot.define do
  factory :answer do
    title { "MyString" }
    body { "MyText" }
    user
    question
  end

  factory :invalid_answer, class: 'Question' do
    title { nil }
    body { nil }
    user
    question
  end
end
