class User::EventController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events
    p current_user
  end

  def new
    @event = Event.new
    @genres = Genre.all
    @subgenres = Subgenre.all
  end

  def create
    @event = Event.new(event_params.except(:genre_id))
    @event.user = current_user
  
    if @event.latitude.blank? || @event.longitude.blank?
      @event.errors.add(:address, 'マップにピンが刺されていません')
      load_genres_and_subgenres
      render :new, status: :unprocessable_entity and return
    end

    if @event.start_time.blank? || @event.end_time.blank?
      @event.errors.add(:start_time, '開始時間と終了時間を入力してください')
      load_genres_and_subgenres
      render :new, status: :unprocessable_entity and return
    end
  
    if @event.start_time > @event.end_time
      @event.errors.add(:end_time, "終了時間は開始時間より後である必要があります")
      load_genres_and_subgenres
      render :new, status: :unprocessable_entity and return
    end
  
    if @event.save
      redirect_to user_event_path(@event), notice: 'イベントの登録に成功しました。', turbo: false
    else
      load_genres_and_subgenres
      render :new, status: :unprocessable_entity and return
    end
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

  def load_genres_and_subgenres
    @genres = Genre.all
    @subgenres = Subgenre.all
  end

  def event_params
    params.require(:event).permit(
      :address, :latitude, :longitude, :start_time, :end_time, :comment, :people_count, :position,:genre_id, :subgenre_id, :user_id, :unmetched_gender, :unmatched_age_min, :unmatched_age_max, :is_matched, :is_accepted
    )
  end

end
