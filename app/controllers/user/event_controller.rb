class User::EventController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events
    p current_user
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @event = current_user.events.find_by(id: params[:id])
    
    @matching_users = MatchingEventGroup.where(event_id: @event.id).includes(:user) 
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(
      :address, :latitude, :longitude, :start_time, :end_time, :comment, :people_count, :position, :subgenre_id, :user_id, :unmetched_gender, :unmatched_age_min, :unmatched_age_max, :is_matched, :is_accepted
    )
  end

end
