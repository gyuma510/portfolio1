require 'rails_helper'

RSpec.describe "Users::Registrations", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    before do
      visit new_user_registration_path
    end

    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザーの新規作成に成功すること" do
          fill_in "メールアドレス", with: "test@example.com"
          fill_in "パスワード（６文字以上）", with: user.password
          fill_in "パスワード（確認用）", with: user.password_confirmation
          click_button "アカウント登録"
          expect(current_path).to eq remember_you_records_path
          expect(page).to have_content "本人確認用のメールを送信しました"
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの新規作成に失敗" do
          fill_in "メールアドレス", with: nil
          fill_in "パスワード（６文字以上）", with: user.password
          fill_in "パスワード（確認用）", with: user.password_confirmation
          click_button "アカウント登録"
          expect(current_path).to eq users_path
          expect(page).to have_content "メールアドレスを入力してください"
        end
      end

      context "登録済みアドレス" do
        it "ユーザーの新規作成に失敗すること" do
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード（６文字以上）", with: user.password
          fill_in "パスワード（確認用）", with: user.password_confirmation
          click_button "アカウント登録"
          expect(current_path).to eq users_path
          expect(page).to have_content "メールアドレスはすでに存在します"
        end
      end

      context "パスワードが未入力" do
        it "ユーザーの新規作成に失敗すること" do
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード（６文字以上）", with: nil
          fill_in "パスワード（確認用）", with: user.password_confirmation
          click_button "アカウント登録"
          expect(current_path).to eq users_path
          expect(page).to have_content "パスワード（６文字以上）を入力してください"
        end
      end

      context "パスワードが６文字未満" do
        it "ユーザーの新規作成に失敗すること" do
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード（６文字以上）", with: "11111"
          fill_in "パスワード（確認用）", with: "11111"
          click_button "アカウント登録"
          expect(current_path).to eq users_path
          expect(page).to have_content "パスワード（６文字以上）は6文字以上で入力してください"
        end
      end
    end
  end
  describe "ログイン後" do
    before do
      sign_in user
      visit edit_user_registration_path
    end

    describe "アカウント編集" do
      context "フォームの入力値が正常" do
        it "ユーザーの編集に成功すること" do
          fill_in "メールアドレス", with: "test@example.com"
          fill_in "パスワード（６文字以上）", with: "123456"
          fill_in "パスワード（確認用）", with: "123456"
          fill_in "現在のパスワード", with: user.password
          click_button "更新"
          expect(current_path).to eq remember_you_records_path
          expect(page).to have_content "アカウント情報を変更しました"
        end
      end

      context "現在のパスワードの入力値が正常でない" do
        it "ユーザーの編集に失敗すること" do
          fill_in "メールアドレス", with: "test@example.com"
          fill_in "パスワード（６文字以上）", with: "123456"
          fill_in "パスワード（確認用）", with: "123456"
          fill_in "現在のパスワード", with: "111111"
          click_button "更新"
          expect(current_path).to eq users_path
          expect(page).to have_content "現在のパスワードは不正な値です"
        end
      end

      context "アカウント削除" do
        it "アカウント削除に成功し、トップページにアクセスすること" do
          click_button "アカウントを削除"
          expect(current_path).to eq remember_you_records_path
          expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
        end
      end

      context "戻るボタン" do
        it "戻るボタンを押下して、トップページにアクセスすること" do
          click_link "戻る"
          expect(current_path).to eq remember_you_records_path
        end
      end
    end
  end
  describe "ゲストユーザー編集" do
    before do
      visit remember_you_records_path
      click_link "ゲストログイン(企業様ログインページ)"
      click_link "アカウント"
      visit edit_user_registration_path
    end

    it "現在のパスワードがランダムに作成されているため、ゲストユーザーの編集に失敗すること" do
      fill_in "メールアドレス", with: "guests@example.com"
      fill_in "パスワード（６文字以上）", with: nil
      fill_in "パスワード（確認用）", with: nil
      fill_in "現在のパスワード", with: nil
      click_button "更新"
      expect(current_path).to eq remember_you_records_path
      expect(page).to have_content "ゲストユーザーの更新・削除はできません"
    end

    it "ゲストユーザーが削除できないこと" do
      click_button "アカウントを削除"
      expect(current_path).to eq remember_you_records_path
      expect(page).to have_content "ゲストユーザーの更新・削除はできません"
    end
  end
end
