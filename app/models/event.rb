class Event < ApplicationRecord
  belongs_to :subgenre
  belongs_to :user
  has_many :matching_event_groups
  validates :address, :latitude, :longitude, :start_time, :end_time, :subgenre_id, presence: true
end
