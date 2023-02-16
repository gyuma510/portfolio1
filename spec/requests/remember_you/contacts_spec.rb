require 'rails_helper'

RSpec.describe "RememberYou::contacts", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact) }

  describe "GET /remember_you/contacts/" do
    context "ログインしていない場合" do
      it "ログイン画面にアクセスすること" do
        get new_user_session_path
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get new_remember_you_contact_path
      end

      it "お問い合わせページが表示されること" do      
        expect(response).to have_http_status(200)
      end
    end
  end
end
