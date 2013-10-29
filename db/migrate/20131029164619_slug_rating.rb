class SlugRating < ActiveRecord::Migration
  def change
    rename_column(:places, :language, :slug)
    add_column(:places, :rating, :float)
  end
end
