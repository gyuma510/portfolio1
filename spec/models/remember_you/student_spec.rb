require 'rails_helper'

RSpec.describe "Studentモデルのテスト", type: :model do
  describe "バリデーションテスト" do
    let(:user) { create(:user) }
    let(:team) { create(:team, user_id: user.id) }
    let(:student) { create(:student, team_id: team.id) }

    subject { test_student.valid? }
    let(:test_student) { student }

    context "student_nameカラム" do
      it "空欄でないこと" do
        test_student.student_name = ''
        is_expected.to eq false;
      end
    end
  end
  describe "アソシエーションテスト" do
    context "user,teamモデルとの関係" do
      it "N:1となっている" do
        expect(Student.reflect_on_association(:user).macro).to eq :belongs_to
        expect(Student.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
