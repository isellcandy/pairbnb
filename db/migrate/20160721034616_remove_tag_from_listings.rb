class RemoveTagFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :tag, :string
  end
end
