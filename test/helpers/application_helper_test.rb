require "test_helper"

describe ApplicationHelper do
  describe "readable_date" do
    it "produces a span with a title text" do
      date = Book.first.created_at

      result = readable_date(date)

      expect(result).must_include date.to_s
    end

    it "returns [unknown] if the date is nil" do
      date = nil

      result = readable_date(date)

      expect(result).must_equal "[unknown]"
    end

  end
end
