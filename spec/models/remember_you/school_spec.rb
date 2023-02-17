require 'rails_helper'

RSpec.describe "Schoolモデルのテスト", type: :model do
  describe "アソシエーションテスト" do
    context "user,teamモデルとの関係" do
      it "N:1となっている" do
        expect(School.reflect_on_association(:user).macro).to eq :belongs_to
        expect(School.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
