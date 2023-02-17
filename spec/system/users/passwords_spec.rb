require 'rails_helper'

RSpec.describe "Users::Passwordss", type: :system do
  let(:user) { create(:user) }

  describe "パスワード機能" do
    it "「パスワードを忘れた方は」が表示されること" do
      visit new_user_session_path
      click_link "パスワードをお忘れの方"
      expect(current_path).to eq new_user_password_path
      within ".headline" do
        expect(page).to have_content "FORGOT PASSWORD"
      end
    end

    before do
      visit new_user_session_path
      click_link "パスワードをお忘れの方"
    end

    context "フォームの入力値が正常" do
      it "パスワード再設定メールの送信に成功すること" do
        fill_in "user[email]", with: user.email
        click_button "パスワード再設定メールを送る"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "パスワードの再設定について数分以内にメールでご連絡いたします。"
      end
    end

    context "メールアドレスが未入力" do
      it "パスワード再設定メールの送信に失敗すること" do
        fill_in "user[email]", with: nil
        click_button "パスワード再設定メールを送る"
        expect(current_path).to eq user_password_path
        expect(page).to have_content "メールアドレスを入力してください"
      end
    end
  end
end
