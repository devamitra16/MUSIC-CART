# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "iOS client", redirect_uri: "", scopes: "")
  Doorkeeper::Application.create(name: "Android client", redirect_uri: "", scopes: "")
  Doorkeeper::Application.create(name: "React", redirect_uri: "", scopes: "")
end