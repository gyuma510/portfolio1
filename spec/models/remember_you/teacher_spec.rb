require 'rails_helper'

RSpec.describe "Teacherモデルのテスト", type: :model do
  describe "バリデーションテスト" do
    let(:user) { create(:user) }
    let(:team) { create(:team, user_id: user.id) }
    let(:teacher) { create(:teacher, team_id: team.id) }

    subject { test_teacher.valid? }
    let(:test_teacher) { teacher }

    context "teacher_nameカラム" do
      it "空欄でないこと" do
        test_teacher.teacher_name = ''
        is_expected.to eq false;
      end
    end
  end
  describe "アソシエーションテスト" do
    context "user,teamモデルとの関係" do
      it "N:1となっている" do
        expect(Teacher.reflect_on_association(:user).macro).to eq :belongs_to
        expect(Teacher.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
