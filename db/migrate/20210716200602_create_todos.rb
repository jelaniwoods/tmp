class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.integer :user_id
      t.datetime :due_on
      t.datetime :completed_on

      t.timestamps
    end
  end
end
