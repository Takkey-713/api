class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :explanation
      t.date :deadline_date
      t.references :board, foreign_key: true
      t.references :user, foreign_key: true
      t.references :list, foreign_key: true
      t.timestamps
    end
  end
end
