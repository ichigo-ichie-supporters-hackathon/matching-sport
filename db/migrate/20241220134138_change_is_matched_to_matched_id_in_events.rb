class ChangeIsMatchedToMatchedIdInEvents < ActiveRecord::Migration[7.0]
  def change
     # is_matched カラムを削除
     remove_column :events, :is_matched, :boolean

     # matched_id カラムを references 型で追加
     add_reference :events, :matched, foreign_key: { to_table: :events }
  end
end
