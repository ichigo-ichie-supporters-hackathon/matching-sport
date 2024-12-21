class Event < ApplicationRecord
  belongs_to :subgenre
  belongs_to :user
  belongs_to :matched_event, class_name: 'Event', foreign_key: 'matched_id', optional: true
  has_many :matching_events, class_name: 'Event', foreign_key: 'matched_id'
  before_create :set_remaining_people

  validates :address, :latitude, :longitude, :start_time, :end_time, :subgenre_id, :people_count, presence: true

  private

  def set_remaining_people
    self.remaining_people = people_count - 1 
  end
end
