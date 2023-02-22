require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "page_title" do
    it "引数が空白であること" do
      expect(page_title("")).to eq ("Remember You")
    end

    it "引数がnilであること" do
      expect(page_title(nil)).to eq("Remember You")
    end

    it "引数が渡されていること" do
      expect(page_title("title")).to eq ("title - Remember You")
    end
  end
end
