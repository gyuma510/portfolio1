class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :kind
      t.integer :ceremony
      t.integer :user_id

      t.timestamps
    end
  end
end
