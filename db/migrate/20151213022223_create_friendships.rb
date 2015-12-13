class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships, id: false do |t|
      t.belongs_to :user
      t.belongs_to :friend
      t.boolean :is_blocked

      t.timestamps null: false
    end
  end
end
