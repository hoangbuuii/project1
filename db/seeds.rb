User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true)

20.times do |n|
  name  = Faker::LeagueOfLegends.champion
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: false)
end

users = User.order(:created_at).take(15)
10.times do
  title = Faker::LeagueOfLegends.rank
  content = Faker::LeagueOfLegends.quote
  users.each { |user| user.microposts.create!(title: title, content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

microposts = Micropost.order(:created_at).take(100)
10.times do
  content = Faker::LeagueOfLegends.masteries
  num = Random.new 
  microposts.each { |micropost| micropost.comments.create!(user_id: num.rand(1..20), content: content) }
end
