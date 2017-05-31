if Rails.env.test? || Rails.env.production?
  fail 'You shall only seed in development!'
end

if Rails.env.development?
  User.destroy_all
  User.create!(username: 'hanswurst', email: 'hans@wurst.com', password: 'admin1', role: 'admin')
end