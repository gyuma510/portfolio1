require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  describe "GET /users/sign_in" do
    before do
      get new_user_session_path
    end

    it 'ログイン画面の表示に成功すること' do
      expect(response).to have_http_status(200)
    end
    
    it "「アカウント登録はこちら」ボタンが表示されていること" do
      expect(response.body).to include "こちら"
    end
  end
end
