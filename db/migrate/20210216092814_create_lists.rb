class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
