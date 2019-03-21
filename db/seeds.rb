User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             gender: "male",
             date_of_birth: "27/08/1998",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  gender = "male"
  date_of_birth = "27/08/1998"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               gender: gender,
               date_of_birth: date_of_birth)
end
