require 'spec_helper'

describe Medium do
  it "has a valid factory" do
    create(:medium).should be_valid
  end

  it "is invalid without a title" do
    build(:medium, title: nil).should_not be_valid
  end

  it "is invalid when url format is invalid" do
    build(:event, url: %w[event,com event example.event@foo.
                     foobar-com]).should_not be_valid
  end

  it "is valid when url format is valid" do
    build(:event, url: "http://example.com").should be_valid
  end

  before do
    @media = Medium.new(title: "Example Media", description: "Example Description", url: "http://www.example.com")
  end

  subject { @media }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }

  it { should be_valid }

  describe "when title is not present" do
    before { @media.title = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { @media.url = " " }
    it { should_not be_valid }
  end

  describe "when url format is invalid" do
    it "is invalid" do
      urls = %w[media,com media example.media@foo. foobar-com]
      urls.each do |invalid_url|
        @media.url = invalid_url
        @media.should_not be_valid
      end
    end
  end

  describe "when url format is valid" do
    it "is valid" do
      urls = %w[http://mediabar.b.org]
      urls.each do |valid_url|
        @media.url = valid_url
        @media.should be_valid
      end
    end
  end
end
