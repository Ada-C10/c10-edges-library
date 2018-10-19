require "test_helper"

describe Author do
  let(:author) { authors(:metz) }

  it "must be valid" do
    value(author).must_be :valid?
  end
end
