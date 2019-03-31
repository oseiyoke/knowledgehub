class CreateJoinTableUserTag < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :tags do |t|
      t.index [:user_id, :tag_id]
    end
  end
end
