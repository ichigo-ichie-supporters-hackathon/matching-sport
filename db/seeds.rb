# Define Genres and SubGenres
genres = [
  { name: '野球観戦', subgenres: ['巨人観戦', '阪神タイガース観戦', '広島カープ観戦', '中日ドラゴンズ観戦', '横浜DeNAベイスターズ観戦'] },
  { name: '野球', subgenres: ['キャッチボール', '草野球試合', '広場でトスバッティング', 'バッティングセンター', '守備練習'] },
  { name: 'サッカー観戦', subgenres: ['浦和レッズ観戦', '鹿島アントラーズ観戦', '川崎フロンターレ観戦', 'ガンバ大阪観戦', 'ヴィッセル神戸観戦'] },
  { name: 'サッカー', subgenres: ['フットサル', 'リフティング練習', 'シュート練習', 'パス練習', 'ミニゲーム'] },
  { name: 'バスケットボール', subgenres: ['1on1', 'フリースロー練習', 'シュート練習', '3ポイント練習', 'ピックアップゲーム'] },
  { name: 'テニス', subgenres: ['ダブルスゲーム', 'サーブ練習', 'ラリー練習', 'ボレー練習', 'テニススクール'] },
  { name: 'マラソン', subgenres: ['5kmランニング', '10kmランニング', 'ハーフマラソン', 'フルマラソン', 'リレーランニング'] },
  { name: 'スキー・スノーボード', subgenres: ['スキー練習', 'スノーボード練習', 'ゲレンデ観光', 'ナイトスキー', '初心者レッスン'] }
]

# Create Users
5.times do |n|
  User.create!(
    name: "テスト太郎#{n}",
    age: 20 + n,
    gender: rand(1..2),
    email: "test#{n}@example.com",
    password: "password"
  )
end

# Create Genres and SubGenres
genres.each_with_index do |genre, index|
  created_genre = Genre.create!(name: genre[:name])
  genre[:subgenres].each do |subgenre_name|
    Subgenre.create!(
      name: subgenre_name,
      genre_id: created_genre.id
    )
  end
end

# Create Events
locations = [
  { address: '東京ドーム', latitude: 35.705439, longitude: 139.751682 },
  { address: '埼玉スタジアム2002', latitude: 35.903586, longitude: 139.713686 },
  { address: '甲子園球場', latitude: 34.721424, longitude: 135.362156 },
  { address: '味の素スタジアム', latitude: 35.664041, longitude: 139.527577 },
  { address: '横浜スタジアム', latitude: 35.443707, longitude: 139.640149 }
]

subgenres = Subgenre.all
users = User.all

200.times do |n|
  location = locations.sample
  Event.create!(
    address: location[:address],
    latitude: location[:latitude],
    longitude: location[:longitude],
    start_time: DateTime.now + n.hours,
    end_time: DateTime.now + n.hours + rand(1..5).hours,
    comment: "イベントコメント#{n}",
    people_count: rand(1..10),
    position: "ポジション#{n % 5}",
    subgenre_id: subgenres.sample.id,
    user_id: users.sample.id,
    unmetched_gender: rand(1..2),
    unmatched_age_min: rand(18..30),
    unmatched_age_max: rand(31..50),
    matched_id: (n % 10 == 0 ? Event.first&.id : nil),
    is_accepted: [true, false].sample
  )
end

puts 'Seeding completed!'
