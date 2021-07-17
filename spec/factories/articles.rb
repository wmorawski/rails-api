FactoryBot.define do
  sequence :slug do |n|
    "sample-article-#{n}"
  end
end

FactoryBot.define do
  factory :article do
    title { "Sample article" }
    content { "Sample content" }
    slug { generate(:slug) }
  end
end
