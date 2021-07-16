class AddUserReferenceToTodos < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :todos, :users
    add_index :todos, :user_id
    change_column_null :todos, :user_id, false
  end
end
