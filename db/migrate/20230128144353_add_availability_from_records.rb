class AddAvailabilityFromRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :availability, :boolean
  end
end
