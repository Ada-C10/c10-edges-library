require "test_helper"

describe User do
  let(:user) { users(:ada) }

  it "must be valid" do
    value(user).must_be :valid?
  end
end
