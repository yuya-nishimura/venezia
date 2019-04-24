class AddColumnToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :check, :boolean, default: false, null: false
    #Ex:- :default =>''
  end
end
