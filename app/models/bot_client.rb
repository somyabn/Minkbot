require_relative 'bot'



bot_client = Bot.new(name: "minkbot", data_file: "bot_data")

puts bot_client.name
puts bot_client.greeting
puts bot_text = bot_client.response_to("i am different")
puts bot_client.farewell
