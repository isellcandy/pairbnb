class RemoveAvatarFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :avatar, :json
  end
end
