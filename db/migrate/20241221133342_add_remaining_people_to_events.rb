class AddRemainingPeopleToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :remaining_people, :integer
  end
end
