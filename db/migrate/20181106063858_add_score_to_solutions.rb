class AddScoreToSolutions < ActiveRecord::Migration[5.2]
  def change
    add_column :solutions, :score, :float
  end
end
