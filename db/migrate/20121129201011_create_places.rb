class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :address
      t.string :name
      t.string :city
      t.string :country
      t.string :language
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
