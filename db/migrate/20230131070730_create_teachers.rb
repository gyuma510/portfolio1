class CreateTeachers < ActiveRecord::Migration[6.1]
  def change
    create_table :teachers do |t|
      t.string :teacher_name
      t.string :teacher_position
      t.text :teacher_others
      t.boolean :teacher_availability
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
