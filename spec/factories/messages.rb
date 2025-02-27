FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    user
    chat_room
  end
end
