# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do |n|
  User.create!(
    name: "テスト太郎#{n}",
    age: n,
    gender: rand(1..2),
    email: "test#{n}@example.com",
    password: "password",
  )
end

5.times do |n|
  Genre.create!(
    name: "スポーツ#{n}"
  )
end

5.times do |n|
  Subgenre.create!(
    name: "サブスポーツ#{n}",
    genre_id: Genre.find(n+1).id
  )
end

address = ["東京都新宿区", "茨城県つくば市", "岡山県岡山市", "北海道札幌", "沖縄県那覇市"]

5.times do |n|
   Event.create!(
    address: "#{address[n]}",
    latitude: rand * 180 - 90,
    longitude: rand * 360 - 180,
    start_time: DateTime.now + n.day,
    end_time: DateTime.now + n.day + n.hours,
    comment: "コメント#{n}",
    people_count: n + 1,
    position: "ポジション#{n}",
    subgenre_id: Subgenre.find(n+1).id,
    user_id: User.find(n+1).id,
    unmetched_gender: rand(1..2),
    unmatched_age_min: n + 10,
    unmatched_age_max: (n+10)*3,
    is_matched: [true, false].sample,
    is_accepted: [true, false].sample
  )
end

# 場所と日時が一致しているモデル
Event.create!(
    address: "同じアドレス",
    latitude: 0,
    longitude: 0,
    start_time: DateTime.now,
    end_time: DateTime.now,
    comment: "コメント",
    people_count: 2,
    position: "ポジション",
    subgenre_id: Subgenre.find(1).id,
    user_id: User.find(1).id,
    unmetched_gender: 1,
    unmatched_age_min: 10,
    unmatched_age_max: 30,
    is_matched: false,
    is_accepted: false
  )
  Event.create!(
    address: "同じアドレス",
    latitude: 0,
    longitude: 0,
    start_time: DateTime.now,
    end_time: DateTime.now,
    comment: "コメント",
    people_count: 2,
    position: "ポジション",
    subgenre_id: Subgenre.find(1).id,
    user_id: User.find(2).id,
    unmetched_gender: 1,
    unmatched_age_min: 10,
    unmatched_age_max: 30,
    is_matched: false,
    is_accepted: false
  )
  

5.times do |n|
  MatchingEventGroup.create!(
    user_id: User.find(n+1).id, 
    event_id: Event.find(n+1).id
  )
end
