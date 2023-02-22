class AddTypeToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :type, :string
    add_column :records, :graduation, :integer
    add_column :records, :ceremony, :integer
    add_column :records, :teacher_name, :string
    add_column :records, :teacher_kana, :string
    add_column :records, :teacher_position, :string
    add_column :records, :teacher_others, :text
    add_column :records, :name, :string
    add_column :records, :kana, :string
    add_column :records, :club, :string
    add_column :records, :others, :text
    add_column :records, :user_id, :integer
  end
end
