class CreateSubgenres < ActiveRecord::Migration[7.0]
  def change
    create_table :subgenres do |t|
      t.string :name
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
