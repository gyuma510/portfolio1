require 'rails_helper'

RSpec.describe "Users::Sessions", type: :system do
  let(:user) { create(:user) }

  describe "ログイン機能" do
    before do
      visit new_user_session_path
    end

    context "フォームの入力値が正常" do
      it "ユーザーのログインに成功すること" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード（６文字以上）", with: user.password
        click_button "ログイン"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "ログインしました。"
      end
    end

    context "メールアドレスが未入力" do
      it "ユーザーのログインに失敗すること" do
        fill_in "メールアドレス", with: nil
        fill_in "パスワード（６文字以上）", with: user.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "登録されていないメールアドレス" do
      it "ユーザーのログインに失敗すること" do
        fill_in "メールアドレス", with: "12345@co.jp"
        fill_in "パスワード（６文字以上）", with: user.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "パスワードが未入力" do
      it "ユーザーのログインに失敗すること" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード（６文字以上）", with: nil
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "登録されていないパスワード" do
      it "ユーザーのログインに失敗すること" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード（６文字以上）", with: "123456"
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "４回アクセスに失敗" do
      it "アカウントロックの警告が表示されること" do
        4.times do |i|
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード（６文字以上）", with: "123456"
          click_button "ログイン"
        end
        expect(page).to have_content "もう一回誤るとアカウントがロックされます。"
      end
    end

    context "５回アクセスに失敗" do
      it "アカウントロックの警告が表示されること" do
        5.times do |i|
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード（６文字以上）", with: "123456"
          click_button "ログイン"
        end
        expect(page).to have_content "アカウントはロックされています。"
      end
    end
  end

  describe "ゲストログイン" do
    it "ゲストログインに成功すること" do
      visit remember_you_records_path
      click_link "ゲストログイン(企業様ログインページ)"
      expect(current_path).to eq remember_you_records_path
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
    end
  end
end
