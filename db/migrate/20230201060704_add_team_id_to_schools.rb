class AddTeamIdToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :team_id, :integer
  end
end
