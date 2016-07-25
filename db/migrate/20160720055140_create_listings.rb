class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.string :tag
      t.decimal :price
      t.string :propertytype
      t.string :roomtype
      t.integer :numberofguess

      t.timestamps null: false
    end
  end
end
