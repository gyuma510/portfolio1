require 'rails_helper'

RSpec.describe "RememberYou::Records", type: :system do
  let!(:user) { create(:user) }
  let!(:team) { create(:team, user_id: user.id) }
  let!(:teacher) { create(:teacher, team_id: team.id) }
  let!(:student) { create(:student, team_id: team.id) }
  let!(:school) { create(:school, team_id: team.id) }

  describe "トップページ" do
    before do
      visit remember_you_records_path
    end

    context "ログインしていない場合" do
      it "アプリの紹介文が表示されること" do
        within ".headline" do 
          expect(page).to have_content "What's"
        end
      end

      it "ヘッダーに「アカウント登録」が表示されていること" do
        within ".navbar-collapse" do
          expect(page).to have_content "アカウント登録"
        end
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        visit remember_you_records_path
      end

      it "登録した卒業年度が表示されていること" do
        within ".text-info" do
          expect(page).to have_content team.graduation.to_s
        end
      end

      it "ヘッダーに「ログアウト」が表示されていること" do
        within ".navbar-collapse" do
          expect(page).to have_content "ログアウト"
        end
      end

      it "検索フォームが表示されていること" do
        within ".team_search" do
          expect(page).to have_content "教員氏名"
        end
      end
    end
  end
  describe "新規作成ページ" do
    before do
      sign_in user
      visit remember_you_records_path
    end

    it "新規作成ボタンを押下して、新規作成ページへアクセスすること" do
      click_link "新規作成"
      expect(current_path).to eq new_remember_you_record_path
      within ".headline" do
        expect(page).to have_content "New Memory"
      end
    end
  end

  describe "新規作成機能" do
    before do
      sign_in user
      visit remember_you_records_path
      click_link "新規作成"
      visit new_remember_you_record_path
    end

    context "フォームの入力値が正常" do
      it "新規作成に成功すること" do
        fill_in "team[graduation]", with: team.graduation
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        check "team[teachers_attributes][][teacher_availability]", match: :first
        fill_in "team[teachers_attributes][][teacher_name]", with: teacher.teacher_name, match: :first
        fill_in "team[teachers_attributes][][teacher_others]", with: teacher.teacher_others, match: :first
        check "team[students_attributes][][student_availability]", match: :first
        fill_in "team[students_attributes][][student_name]", with: student.student_name, match: :first
        fill_in "team[students_attributes][][student_kana]", with: student.student_kana, match: :first
        fill_in "team[students_attributes][][student_others]", with: student.student_others, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "保存されました"
      end
    end

    context "任意の項目が未入力" do
      it "新規作成に成功すること" do
        fill_in "team[graduation]", with: team.graduation
        check "team[teachers_attributes][][teacher_availability]", match: :first
        fill_in "team[teachers_attributes][][teacher_name]", with: teacher.teacher_name, match: :first
        check "team[students_attributes][][student_availability]", match: :first
        fill_in "team[students_attributes][][student_name]", with: student.student_name, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "保存されました"
      end
    end

    context "卒業年度が未入力" do
      it "新規作成に失敗すること" do
        fill_in "team[graduation]", with: nil
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        check "team[teachers_attributes][][teacher_availability]", match: :first
        fill_in "team[teachers_attributes][][teacher_name]", with: teacher.teacher_name, match: :first
        fill_in "team[teachers_attributes][][teacher_others]", with: teacher.teacher_others, match: :first
        check "team[students_attributes][][student_availability]", match: :first
        fill_in "team[students_attributes][][student_name]", with: student.student_name, match: :first
        fill_in "team[students_attributes][][student_kana]", with: student.student_kana, match: :first
        fill_in "team[students_attributes][][student_others]", with: student.student_others, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "卒業年度を入力してください"
      end
    end

    context "登録にチェックを入れた教員の氏名が未入力" do
      it "新規作成に失敗すること" do
        fill_in "team[graduation]", with: team.graduation
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        check "team[teachers_attributes][][teacher_availability]", match: :first
        fill_in "team[teachers_attributes][][teacher_name]", with: nil, match: :first
        fill_in "team[teachers_attributes][][teacher_others]", with: teacher.teacher_others, match: :first
        check "team[students_attributes][][student_availability]", match: :first
        fill_in "team[students_attributes][][student_name]", with: student.student_name, match: :first
        fill_in "team[students_attributes][][student_kana]", with: student.student_kana, match: :first
        fill_in "team[students_attributes][][student_others]", with: student.student_others, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "教員の氏名を入力してください"
      end
    end

    context "登録にチェックを入れた生徒の氏名が未入力" do
      it "新規作成に失敗すること" do
        fill_in "team[graduation]", with: team.graduation
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        check "team[teachers_attributes][][teacher_availability]", match: :first
        fill_in "team[teachers_attributes][][teacher_name]", with: teacher.teacher_name, match: :first
        fill_in "team[teachers_attributes][][teacher_others]", with: teacher.teacher_others, match: :first
        check "team[students_attributes][][student_availability]", match: :first
        fill_in "team[students_attributes][][student_name]", with: nil, match: :first
        fill_in "team[students_attributes][][student_kana]", with: student.student_kana, match: :first
        fill_in "team[students_attributes][][student_others]", with: student.student_others, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "生徒の氏名を入力してください"
      end
    end

    context "登録にチェックを入れない場合" do
      it "チェックを入れていない教員と生徒の情報は保存されないこと" do
        fill_in "team[graduation]", with: "2025"
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        fill_in "team[teachers_attributes][][teacher_name]", with: teacher.teacher_name, match: :first
        fill_in "team[teachers_attributes][][teacher_others]", with: teacher.teacher_others, match: :first
        fill_in "team[students_attributes][][student_name]", with: student.student_name, match: :first
        fill_in "team[students_attributes][][student_kana]", with: student.student_kana, match: :first
        fill_in "team[students_attributes][][student_others]", with: student.student_others, match: :first
        click_button "登録する"
        expect(current_path).to eq remember_you_records_path
        click_link "2025"
        expect(page).not_to have_content teacher.teacher_name
      end
    end

    context "戻るボタン" do
      it "戻るボタンを押下して、トップページにアクセスすること" do
        click_link "戻る"
        expect(current_path).to eq remember_you_records_path
      end
    end
  end

  describe "詳細ページ" do
    before do
      sign_in user
      visit remember_you_records_path
      click_link team.graduation
      visit remember_you_record_path(team.id)
    end
  
    it "登録された情報が表示されていること" do
      expect(page).to have_content team.graduation
      expect(page).to have_content school.school_name
      expect(page).to have_content school.kind
      expect(page).to have_content school.ceremony
      expect(page).to have_content teacher.teacher_name
      expect(page).to have_content teacher.teacher_position
      expect(page).to have_content teacher.teacher_others
      expect(page).to have_content student.student_name
      expect(page).to have_content student.student_kana
      expect(page).to have_content student.student_club
      expect(page).to have_content student.student_others
    end

    it "登録されていない情報が表示されていないこと" do
      expect(page).not_to have_content "2026"
      expect(page).not_to have_content "山田"
      expect(page).not_to have_content "野球"
    end

    it "削除ボタンを押下してデータを削除した後、トップページへアクセスすること" do
      click_link "削除"
      expect(current_path).to eq remember_you_records_path
      expect(page).to have_content "削除しました"
      expect(page).not_to have_content team.graduation
    end

    it "一覧ページへ戻るボタンを押下して、トップページへアクセスすること" do
      click_link "一覧ページへ戻る"
      expect(current_path).to eq remember_you_records_path
    end
  end

  describe "編集ページ" do
    before do
      sign_in user
      visit remember_you_record_path(team.id)
    end

    it "編集ボタンを押下して、編集ページへアクセスすること" do
      click_link "編集"
      expect(current_path).to eq edit_remember_you_record_path(team.id)
      within ".headline" do
        expect(page).to have_content "Edit"
      end
    end
  end

  describe "編集機能" do
    before do
      sign_in user
      visit remember_you_record_path(team.id)
      click_link "編集"
      visit edit_remember_you_record_path(team.id)
    end

    context "フォームの入力値が正常" do
      it "編集に成功すること" do    
        fill_in "team[graduation]", with: "2028"
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        fill_in "team[teachers_attributes][0][teacher_name]", with: "加藤一郎"
        fill_in "team[teachers_attributes][0][teacher_others]", with: teacher.teacher_others
        fill_in "team[students_attributes][0][student_name]", with: "伊藤一郎"
        fill_in "team[students_attributes][0][student_kana]", with: student.student_kana
        fill_in "team[students_attributes][0][student_others]", with: student.student_others
        click_button "編集を完了する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "保存されました"
      end
    end

    context "卒業年度が未入力" do
      it "編集に失敗すること" do    
        fill_in "team[graduation]", with: nil
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        fill_in "team[teachers_attributes][0][teacher_name]", with: "加藤一郎"
        fill_in "team[teachers_attributes][0][teacher_others]", with: teacher.teacher_others
        fill_in "team[students_attributes][0][student_name]", with: "伊藤一郎"
        fill_in "team[students_attributes][0][student_kana]", with: student.student_kana
        fill_in "team[students_attributes][0][student_others]", with: student.student_others
        click_button "編集を完了する"
        expect(current_path).to eq remember_you_record_path(team.id)
        expect(page).to have_content "卒業年度を入力してください"
      end
    end

    context "教員の氏名が未入力" do
      it "編集に失敗すること" do    
        fill_in "team[graduation]", with: "2028"
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        fill_in "team[teachers_attributes][0][teacher_name]", with: nil
        fill_in "team[teachers_attributes][0][teacher_others]", with: teacher.teacher_others
        fill_in "team[students_attributes][0][student_name]", with: "伊藤一郎"
        fill_in "team[students_attributes][0][student_kana]", with: student.student_kana
        fill_in "team[students_attributes][0][student_others]", with: student.student_others
        click_button "編集を完了する"
        expect(current_path).to eq remember_you_record_path(team.id)
        expect(page).to have_content "教員の氏名を入力してください"
      end
    end

    context "生徒の氏名が未入力" do
      it "編集に失敗すること" do    
        fill_in "team[graduation]", with: "2028"
        fill_in "team[schools_attributes][0][school_name]", with: school.school_name
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: school.ceremony
        fill_in "team[teachers_attributes][0][teacher_name]", with: "加藤一郎"
        fill_in "team[teachers_attributes][0][teacher_others]", with: teacher.teacher_others
        fill_in "team[students_attributes][0][student_name]", with: nil
        fill_in "team[students_attributes][0][student_kana]", with: student.student_kana
        fill_in "team[students_attributes][0][student_others]", with: student.student_others
        click_button "編集を完了する"
        expect(current_path).to eq remember_you_record_path(team.id)
        expect(page).to have_content "生徒の氏名を入力してください"
      end
    end

    context "任意の項目が未入力" do
      it "編集に成功すること" do    
        fill_in "team[graduation]", with: "2028"
        fill_in "team[schools_attributes][0][school_name]", with: nil
        find("option[value='中学校']").select_option
        fill_in "team[schools_attributes][0][ceremony]", with: nil
        fill_in "team[teachers_attributes][0][teacher_name]", with: "加藤一郎"
        fill_in "team[teachers_attributes][0][teacher_others]", with: nil
        fill_in "team[students_attributes][0][student_name]", with: "伊藤一郎"
        fill_in "team[students_attributes][0][student_kana]", with: nil
        fill_in "team[students_attributes][0][student_others]", with: nil
        click_button "編集を完了する"
        expect(current_path).to eq remember_you_records_path
        expect(page).to have_content "保存されました"
      end
    end

    context "詳細ページへ戻るボタン" do
      it "詳細へ戻るボタン押下で、詳細ページへアクセスすること" do
        click_link "詳細ページへ戻る"
        expect(current_path).to eq remember_you_record_path(team.id)
      end
    end
  end

  describe "検索機能" do
    before do
      sign_in user
      visit remember_you_records_path
    end

    it "検索ボタンを押下して、検索結果ページへアクセスすること" do
      click_button "検索"
      expect(current_path).to eq search_remember_you_records_path
      within ".headline" do
        expect(page).to have_content "SEARCH RESULTS"
      end
    end

    context "検索フォームが未入力" do
      it "登録している卒業年度が表示されること" do
        click_button "検索"
        visit search_remember_you_records_path
        expect(page).to have_content team.graduation
      end
    end

    context "検索フォームに登録した情報を入力" do
      it "検索結果が1件であること" do
        fill_in "q[teachers_teacher_name_cont]", with: teacher.teacher_name
        click_button "検索"
        expect(page).to have_content "検索結果:1件"
      end
    end

    context "教員氏名に登録していない値を入力" do
      it "検索結果が0件であること" do
        fill_in "q[teachers_teacher_name_cont]", with: "あかさたな"
        click_button "検索"
        expect(page).to have_content "検索結果:0件"
      end
    end
  end
end
