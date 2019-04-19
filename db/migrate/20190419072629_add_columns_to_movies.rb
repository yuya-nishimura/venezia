class AddColumnsToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :description, :text
    add_column :movies, :release_date, :date
    add_column :movies, :poster, :string
  end
end
