FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jsmith#{n}" }
    name { "John Smith" }
    url { "https://example.com" }
    avatar_url { "https://example.com/avatar" }
    provider { "github" }
  end
end
