require 'rails_helper'

RSpec.describe "Teamモデルのテスト", type: :model do
  describe "バリデーションテスト" do
    let(:user) { create(:user) }
    let(:team) { create(:team, user_id: user.id) }

    subject { test_team.valid? }
    let(:test_team) { team }

    context "graduationカラム" do
      it "空欄でないこと" do
        test_team.graduation = ''
        is_expected.to eq false;
      end
    end
  end
  describe "アソシエーションテスト" do
    context "userモデルとの関係" do
      it "N:1となっている" do
        expect(Team.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "school,teacher,studentモデルとの関係" do
      it "1:Nとなっている" do
        expect(Team.reflect_on_association(:schools).macro).to eq :has_many
        expect(Team.reflect_on_association(:teachers).macro).to eq :has_many
        expect(Team.reflect_on_association(:students).macro).to eq :has_many
      end
    end
  end
end
