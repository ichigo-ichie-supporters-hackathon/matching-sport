class Event < ApplicationRecord
  belongs_to :subgenre
  belongs_to :user
  has_many :matching_event_groups
end
