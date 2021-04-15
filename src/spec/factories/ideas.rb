FactoryBot.define do
  factory :idea do
    body        {'test'}
    category_id {2}
    association :category
  end
end
