class AddIndexToLists < ActiveRecord::Migration[5.2]
  def change
    add_index :lists, :user_id
    add_index :movies, :list_id
    #Ex:- add_index("admin_users", "username")
  end
end
