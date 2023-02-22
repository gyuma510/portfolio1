class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :student_name
      t.string :student_kana
      t.string :student_club
      t.text :student_others
      t.boolean :student_availability
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
