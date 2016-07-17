100000.times do |i|
  User.create!(
    email: Faker::Internet.user_name + i.to_s +
      "@#{Faker::Internet.domain_name}",
    password:              'foobar12',
    password_confirmation: 'foobar12')
end