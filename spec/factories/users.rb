FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john@example.com" }
  end

  factory :user2, class: User do
    name { "Suman Rahman" }
    email { "suman@example.com" }
  end

  factory :user3, class: User do
    name { "Jawad Sahid" }
    email { "jawad@example.com" }
  end
end