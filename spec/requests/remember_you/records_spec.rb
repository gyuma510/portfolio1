require 'rails_helper'

RSpec.describe "RememberYou::Records", type: :request do
  let!(:user) { create(:user) }
  let!(:team) { create(:team, user_id: user.id) }
  let!(:teacher) { create(:teacher, team_id: team.id) }
  let!(:student) { create(:student, team_id: team.id) }

  describe "GET /remember_you/records" do
    before do
      get remember_you_records_path
    end

    it "トップページが表示されること" do
      get remember_you_records_path
      expect(response).to have_http_status(200)
    end

    context "ログインしていない場合" do
      it "アプリの紹介文が表示されること" do
        expect(response.body).to include "What's"
      end

      it "ヘッダーに「アカウント登録」が表示されていること" do
        expect(response.body).to include "アカウント登録"
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get remember_you_records_path
      end

      it "登録した卒業年度が表示されていること" do
        expect(response.body).to include team.graduation.to_s
      end

      it "ヘッダーに「ログアウト」が表示されていること" do
        expect(response.body).to include "ログアウト"
      end

      it "検索フォームが表示されていること" do
        expect(response.body).to include "教員氏名"
      end
    end
  end
  
  describe "GET /remember_you/records/new" do
    before do
      sign_in user
      get new_remember_you_record_path
    end

    it "新規作成ページが表示されること" do      
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /remember_you/records/:id/" do
    before do
      sign_in user
      get remember_you_record_path(team.id)
    end

    it "詳細ページが表示されること" do      
      expect(response).to have_http_status(200)
    end

    it "登録した卒業年度,教員氏名,生徒氏名が表示されていること" do
      expect(response.body).to include team.graduation.to_s
      expect(response.body).to include teacher.teacher_name
      expect(response.body).to include student.student_name
    end
  end
  
  describe "GET /remember_you/records/:id/edit" do
    before do
      sign_in user
      get edit_remember_you_record_path(team.id)
    end

    it "編集ページが表示されること" do
      expect(response).to have_http_status(200)
    end

    it "登録した卒業年度,教員氏名,生徒氏名が表示されていること" do
      expect(response.body).to include team.graduation.to_s
      expect(response.body).to include teacher.teacher_name
      expect(response.body).to include student.student_name
    end
  end
end
