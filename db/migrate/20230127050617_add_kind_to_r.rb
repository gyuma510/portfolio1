class AddKindToR < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :kind, :string
  end
end
