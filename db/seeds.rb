require 'faker'

User.destroy_all
puts "Cleared existing users."

# create 1000 users
1000.times do
  User.create!(
    name: Faker::Name.unique.name,
    api_token: SecureRandom.hex(20)
  )
rescue ActiveRecord::RecordInvalid => e
  retry # Retry if duplicate name occurs
end

puts "Seeded #{User.count} users successfully."
