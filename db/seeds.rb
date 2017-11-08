User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true)

99.times do |n|
  name  = Faker::LeagueOfLegends.champion
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: false)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::LeagueOfLegends.rank
  content = Faker::LeagueOfLegends.quote
  users.each { |user| user.microposts.create!(title: title, content: content) }
end
