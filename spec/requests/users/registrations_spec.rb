require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  let(:user) { create(:user) }
  let(:team) { create(:team, user_id: user.id) }

  describe "GET /users/sign_up" do
    before do
      get new_user_registration_path
    end

    it "ログインページが表示されること" do
      expect(response).to have_http_status(200)
    end

    it "「アカウント確認メールを送る方」ボタンが表示されていること" do
      expect(response.body).to include "送る方"
    end
  end

  describe "GET /users/edit" do
    before do
      sign_in user
      get edit_user_registration_path(team.id)
    end

    it "アカウント編集ページが表示されること" do
      expect(response).to have_http_status(200)
    end

    it "登録したメールアドレスが表示されていること" do
      expect(response.body).to include user.email
    end
  end
end
