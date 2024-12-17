class Event < ApplicationRecord
  belongs_to :subgenre
  belongs_to :user
end
