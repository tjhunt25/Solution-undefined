class CreateTestPairs < ActiveRecord::Migration[5.2]
  def change
    create_table :test_pairs do |t|
      t.string  :input
      t.string  :output
      t.integer :input_type
      t.integer :output_type
      t.integer :challenge_id

      t.timestamps
    end
  end
end
