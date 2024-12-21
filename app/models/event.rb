class Event < ApplicationRecord
  belongs_to :subgenre
  belongs_to :user
  # belongs_to :event
  belongs_to :matched_event, class_name: 'Event', foreign_key: 'matched_id', optional: true
  has_many :matching_events, class_name: 'Event', foreign_key: 'matched_id'


  has_many :matching_event_groups
  validates :address, :latitude, :longitude, :start_time, :end_time, :subgenre_id, :people_count, presence: true
end
