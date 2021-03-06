require "rails_helper"

RSpec.describe Article, type: :model do
  describe "#validations" do
    let(:article) { build(:article) }

    it "tests that factory is valid" do
      expect(article).to be_valid
    end

    # rubocop:disable RSpec/MultipleExpectations
    it "has an invalid title" do
      article.title = ""
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "has an invalid content" do
      article.content = ""
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it "has an invalid slug" do
      article.slug = ""
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    it "validates the uniqueness of the slug" do
      first_article = create(:article)
      expect(first_article).to be_valid

      second_article = build(:article, slug: first_article.slug)
      expect(second_article).not_to be_valid

      expect(second_article.errors[:slug]).to include("has already been taken")
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  describe ".recent" do
    let(:older_article) { create(:article, created_at: 1.hour.ago) }
    let(:recent_article) { create(:article) }

    it "returns articles in the correct order" do
      expect(described_class.recent).to eq(
                                          [recent_article, older_article],
                                        )
    end

    it "return articles in the correct order after update" do
      described_class.update(recent_article.id, created_at: 2.hours.ago)

      expect(described_class.recent).to eq(
                                          [older_article, recent_article],
                                        )
    end
  end
end
