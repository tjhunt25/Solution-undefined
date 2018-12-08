class AddSolutionIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :solution_id,
    :integer
  end
end
