FactoryBot.define do
  factory :recipe1, class: Recipe do
    published_at { '2022-06-03' }
    user
  end

  factory :recipe2, class: Recipe do
    published_at { '2022-06-05' }
    user {build(:user2)}
  end

  factory :recipe3, class: Recipe do
    published_at { '2022-06-25' }
    user {build(:user3)}
  end
  
end