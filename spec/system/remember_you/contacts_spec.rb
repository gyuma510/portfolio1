require 'rails_helper'

RSpec.describe "RememberYou::Contacts", type: :system do
  let(:user) { create(:user) }

  describe "お問い合わせページ" do
    before do
      sign_in user
      visit remember_you_records_path
    end

    it "お問い合わせページが表示されること" do
      click_link "お問い合わせ"
      expect(current_path).to eq new_remember_you_contact_path
      within ".headline" do
        expect(page).to have_content "CONTACT"
      end
    end

    before do
      click_link "お問い合わせ"
      visit new_remember_you_contact_path
    end

    context "フォームの入力値が正常" do
      it "お問い合わせの送信に成功すること" do    
        fill_in "contact[name]", with: "山本"
        fill_in "contact[content]", with: "写真の保存機能を追加して欲しいです。"
        click_button "送信"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "お問い合わせ内容を送信しました"
      end
    end

    context "名前が未入力" do
      it "お問い合わせの送信に失敗すること" do    
        fill_in "contact[name]", with: nil
        fill_in "contact[content]", with: "写真の保存機能を追加して欲しいです。"
        click_button "送信"
        expect(current_path).to eq remember_you_contacts_path
        expect(page).to have_content "名前を入力してください"
      end
    end

    context "お問い合わせ内容が未入力" do
      it "お問い合わせの送信に失敗すること" do    
        fill_in "contact[name]", with: "山本"
        fill_in "contact[content]", with: nil
        click_button "送信"
        expect(current_path).to eq remember_you_contacts_path
        expect(page).to have_content "お問い合わせ内容を入力してください"
      end
    end

    it "ホーム画面へ戻るボタンを押下して、トップページへアクセスすること" do
      click_link "ホーム画面へ戻る"
      expect(current_path).to eq remember_you_records_path
    end
  end
end
