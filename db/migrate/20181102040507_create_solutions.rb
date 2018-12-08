class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.text :code
      t.integer :challenge_id
      t.integer :user_id

      t.timestamps
    end
  end
end
