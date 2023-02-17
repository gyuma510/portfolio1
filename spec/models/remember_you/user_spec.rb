require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "ユーザー登録" do
    it "email,password,password_confirmationが存在すれば登録できること" do
      user = create(:user)
      expect(user).to be_valid
    end
  end

  describe "バリデーションテスト" do
    let(:user) { create(:user) }

    subject { test_user.valid? }
    let(:test_user) { user }

    context "emailカラム" do
      it "空欄でないこと" do
        test_user.email = ''
        is_expected.to eq false;
      end
    end
  end
  describe "アソシエーションテスト" do
    context "team,school,teacher,studentモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:teams).macro).to eq :has_many
        expect(User.reflect_on_association(:schools).macro).to eq :has_many
        expect(User.reflect_on_association(:teachers).macro).to eq :has_many
        expect(User.reflect_on_association(:students).macro).to eq :has_many
      end
    end
  end
end
