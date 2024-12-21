class DropMatchingEventGroups < ActiveRecord::Migration[7.0]
  def up
    drop_table :matching_event_groups
  end

  def down
    create_table :matching_event_groups do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index [:event_id], name: "index_matching_event_groups_on_event_id"
      t.index [:user_id], name: "index_matching_event_groups_on_user_id"
    end
  end
end
