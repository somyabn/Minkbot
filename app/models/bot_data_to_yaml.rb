require 'yaml'
bot_data = {
	:presubs => 
	[
     ["dont" , "do not"],
     ["don't" , "do not"],
     ["your" , "you're"],
     ["love", "like"],
     ["apologize" , "are sorry"],
     ["dislike" , "hate"],
     ["despise", "hate"],
     ["yeah", "yes"],
     ["mom", "family"]
    ],
    :responses =>{
    :default=> [
     "I do not understand.",
     "what?",
     "huh?" ,
     "Tell me about something else",
     "I am tired of this subject" 
      ],
      :greeting => [
     "Hi Iam [name].Want to chat?",
     "whats on your mind today?",
     "Hi. what would you like to talk about?"
      ],
      :farewell => [
     "Good bye","Au reviour!!"
       ],
      'hello' => [
     "Hows it going?",
     "How do you do?"
      ],
      'sorry' => [
      "There's no need to apologize.."
      ],
      'hello' => [
     "Hows it going?",
     "How do you do?"
      ],
      'different' => [
     "The joy of life comes from our encounters with new experiences, and hence there is no greater joy than to have an endlessly changing horizon, for each day to have a new and different sun.",
     "In order to be irreplaceable one must always be different."
      ],
      'everyone *'   => [
     "you think everyone *?",
     "Always remember that you are absolutely unique. Just like everyone else."
      ],
      'do not know'   => [
     "To know what you know and what you do not know, that is true knowledge.",
     "People who know little are usually great talkers, while men who know much say little."
      ],
      'yes' => [
      	"great."
      	]
   }
}
f = File.open(ARGV.first  || 'bot_data', "w")
f.puts bot_data.to_yaml
f.close