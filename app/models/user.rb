class User < ApplicationRecord
  has_many :events
  has_many :matching_event_groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum gender: {other: 0 , male: 1, female: 2}
  with_options presence: true do
    validates :name
    validates :age
  end
end
