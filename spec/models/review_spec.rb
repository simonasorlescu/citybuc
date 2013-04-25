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

  before do
    @review = Review.new(title: "Example Review", description: "example description")
  end

  subject { @review }

  describe "default rating is nil" do
    it { @review.rating.should == nil }
  end

  describe "rating is between 0 and 5" do
    before { @review.rating = 70 }
    it { should be_invalid }
  end


end
