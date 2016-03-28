require 'spec_helper'

describe Review do
  it "has a valid factory" do
    create(:review).should be_valid
  end

  it "is invalid without a title" do
    build(:review, title: nil).should_not be_valid
  end

  it "is invalid without a description" do
    build(:review, description: nil).should_not be_valid
  end

  describe "has rating" do
    before { @review = create :review }

    it "is nil by default" do
      @review.rating.should == nil
    end

    it "is valid between 0 and 5" do
      @review.rating = 3
      @review.should be_valid
    end

    it "is invalid below 0 or over 5" do
      @review.rating = 70
      @review.should be_invalid
    end
  end
end
