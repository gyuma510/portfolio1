class AddSchoolToR < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :school, :string
  end
end
