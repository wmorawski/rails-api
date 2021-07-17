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

    pending "has an invalid content" do
      article.slug = ""
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    pending "has an invalid slug" do
      article.slug = ""
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    pending "validates the uniqueness of the slug" do
      first_article = create(:article)
      expect(first_article).to be_valid
      
      second_article = create(:article, slug: first_article.slug)
      expect(second_article).not_to be_valid

      expect(second_article.errors[:slug]).to include("has already been taken")
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
