class CreateListingtags < ActiveRecord::Migration
  def change
    create_table :listingtags do |t|
      t.integer :listing_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
