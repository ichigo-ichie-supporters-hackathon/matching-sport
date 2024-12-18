class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.datetime :start_time
      t.datetime :end_time
      t.string :comment
      t.integer :people_count
      t.string :position
      t.references :subgenre, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :unmetched_gender
      t.integer :unmatched_age_min
      t.integer :unmatched_age_max
      t.boolean :is_matched, default: false
      t.boolean :is_accepted, default: false

      t.timestamps
    end
  end
end
