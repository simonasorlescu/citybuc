require 'spec_helper'

describe Subscription do

  before do
    @subscription = Subscription.new
  end

  subject { @subscription }

  it { should respond_to(:user) }
  it { should respond_to(:category) }
  it { should respond_to(:location) }

  it { should be_valid }

end
