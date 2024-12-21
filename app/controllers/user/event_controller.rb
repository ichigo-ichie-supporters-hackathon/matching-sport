class User::EventController < ApplicationController
  before_action :authenticate_user!
  require 'geocoder'

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
      # マッチングのアルゴリズムを実装する
      match_event(@event)
    else
      load_genres_and_subgenres
      render :new, status: :unprocessable_entity and return
    end
  end
  

  def edit
  end

  def show
    @event = current_user.events.find_by(id: params[:id])
    
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

  # マッチングのアルゴリズムの内容
  def match_event(new_event)
    # すでにマッチングしていないEventかつ、今の時間よりも開始時間が後のものかつ、自分以外のユーザーが作成したイベントかつ、募集人数が同じイベントを抽出する
    matching_events = Event.where.not(remaining_people: 0).where("start_time > ?", Time.current).where.not(user_id: current_user.id).where(people_count: new_event.people_count)
    # サブジャンルが一致するイベントを優先
    matching_events = matching_events.where(subgenre_id: new_event.subgenre_id)
    # サブジャンルが一致しない場合に、ジャンルを基に絞り込み
    if matching_events.empty?
      matching_events = matching_events.joins(:subgenre).where(subgenres: { genre_id: new_event.subgenre.genre_id })
    end
    

    # 時間でまず絞り込む
    matching_events = matching_events.where("start_time <= ? AND end_time >= ?", new_event.end_time, new_event.start_time)

     # 時間と場所が近いイベントを絞り込み
     matching_events = matching_events.select do |event|
      location_close = Geocoder::Calculations.distance_between([event.latitude, event.longitude], [new_event.latitude, new_event.longitude]) < 5 # 5km以内
      location_close
    end
    # TODO: 条件(マッチングしたくない性別、年齢)に合致するか 
    # 二人だけなら考慮できる、3人以上は勘弁
     
    # 最も近いイベントを選択する TODO: 改良の余地あり？
    best_match_event = matching_events.min_by(&:start_time)
    if best_match_event
      if best_match_event.matched_id.nil?
        best_match_event.update(matched_id: best_match_event.id)
        new_event.update(matched_id: best_match_event.id)
        best_match_event.update(remaining_people: best_match_event.remaining_people-1)
        new_event.update(remaining_people: new_event.remaining_people-1)
      else 
        if best_match_event.matched_id == best_match_event.id
          new_event.update(matched_id: best_match_event.id)
          best_match_event.update(remaining_people: best_match_event.remaining_people-1)
          new_event.update(remaining_people: new_event.remaining_people-1)
          if best_match_event.remaining_people == 0
            Event.where(matched_id: best_match_event.id).update_all(remaining_people: 0)
          end
        else
          oldest_event = Event.where(id: best_match_event.matched_id).first
          new_event.update(matched_id: oldest_event.id)
          best_match_event.update(remaining_people: best_match_event.remaining_people-1)
          new_event.update(remaining_people: new_event.remaining_people-1)
          oldest_event.update(remaining_people: oldest_event.remaining_people-1)
          if oldest_event.remaining_people == 0
            Event.where(matched_id: oldest_event.id).update_all(remaining_people: 0)
          end
        end
      end
      redirect_to user_event_path(@event), notice: 'マッチングに成功しました。', turbo: false
      # TODO: マッチング成功した場合に演出がほしい
    else 
      # マッチングするイベントが見つからなかった場合
      redirect_to user_event_path(@event), notice: 'イベントの登録に成功しました。', turbo: false
    end
  end

end
