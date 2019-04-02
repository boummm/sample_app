User.create!(name: "Boummm",
             email: "boummm1998@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             gender: "male",
             date_of_birth: "27/08/1998",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  gender = "male"
  date_of_birth = "27/08/1998"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               gender: gender,
               date_of_birth: date_of_birth,
               activated: true,
               activated_at: Time.zone.now)
end
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
