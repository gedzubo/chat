FactoryBot.define do
  factory :message do
    body { "Hello World" }
    user
    chat_room
  end
end
