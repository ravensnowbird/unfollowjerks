class AddFollowerIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :follower_ids, :text
  end
end
