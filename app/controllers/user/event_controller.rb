class User::EventController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @genres = Genre.all
    @subgenres = Subgenre.all
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
  
    if @event.save
      redirect_to user_event_path(@event), notice: 'イベントの登録に成功しました。'
    else
      @genres = Genre.all
      @subgenres = Subgenre.where(genre_id: @event.genre_id)
      render :new, status: :unprocessable_entity
    end
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
