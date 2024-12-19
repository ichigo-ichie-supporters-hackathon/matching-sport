class User::EventController < ApplicationController
  def index
    @events = Event.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @event = Event.find(params[:id])
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
