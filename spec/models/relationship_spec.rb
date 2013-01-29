require 'spec_helper'

describe Relationship do

  let(:test_follower) { FactoryGirl.create(:user) }
  let(:test_followed) { FactoryGirl.create(:user) }
  let(:test_relationship) { test_follower.relationships.build(followed_id: test_followed.id) }

  subject { test_relationship }

  it { test_relationship.should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        Relationship.new(follower_id: test_follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { test_relationship.should respond_to(:follower) }
    it { test_relationship.should respond_to(:followed) }
    it { test_relationship.follower.should  == test_follower }
    it { test_relationship.followed.should  == test_followed }
#    its(:follower) { should == test_follower }
#    its(:followed) { should == test_followed }
  end

  describe "when followed id is not present" do
    before { test_relationship.followed_id = nil }
    it { test_relationship.should_not be_valid }
  end

  describe "when follower id is not present" do
    before { test_relationship.follower_id = nil }
    it { test_relationship.should_not be_valid }
  end

end