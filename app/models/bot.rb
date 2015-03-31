require 'yaml'
require_relative 'wordplay'
require 'pry'

class Bot

	BOT_DATA = bot_data = {
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
      'hi' => [
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
      	],
      'sad' => [
      	"Some days are just bad days, that's all. You have to experience sadness to know happiness, and I remind myself that not every day is going to be a good day, that's just the way it is!",
      	"Your pain is the breaking of the shell that encloses your understanding."
      	],
      	'happy' => [
      	"Whoever is happy will make others happy too.You made me happy now...",
      	"Yayyyy!!!"
      	],
      	'confused' => [
      	"You can never control who you fall in love with, even when you're in the most sad, confused time of your life. You don't fall in love with people because they're fun. It just happens.",
      	"Your intellect may be confused, but your emotions will never lie to you.Think from your heart.."
      	],
      	'joke' => [
      	"Wife:I look fat. Can you give me a compliment? Husband: You have perfect eyesight.",
      	"A guy was driving in a car with a blonde. He told her to stick her head out the window and see if the blinker worked. She stuck her head out and said, Yes, No, Yes, No, Yes...",
      	"Do not be racist; be like Mario. He's an Italian plumber, who was made by the Japanese, speaks English, looks like a Mexican, jumps like a black man, and grabs coins like a Jew!"
      	],
   }
}

	attr_reader :name, :data

	#initializes the bot object,loads in the external YAML data file and sets the bots name

	def initialize(options = {})
		@name = options[:name] || "Unnamed Bot"
		begin 
			# @data = YAML.load(File.read(options[:data_file]))
			@data = BOT_DATA
	    rescue
	    	raise "Cant load bot data"
	    end
	end

   # returns a random greeting as specified in the bot's data file.
	def greeting
		random_response(:greeting)
	end
    

   # returns a random farewell as specified in the bot's data file.
	def farewell
		random_response(:farewell)
	end

    #responds to the input text given by the user
	def response_to(input)
		prepared_input = preprocess(input.downcase)
		sentence = best_sentence(prepared_input)
		reversed_sentense = Wordplay.switch_pronouns(sentence)
		responses = possible_responses(sentence)
		return responses[rand(responses.length)]
	end

	private
	# choose a random response phrase from the response hash 
	# and substitutes meta data ino the pharse

	def random_response(key)
		random_index = rand(@data[:responses][key].length)
		@data[:responses][key][random_index].gsub(/\[name\]/,@name)
	end

	#performs preprocessing tasks for all input to the bot

	def preprocess(input)
		perform_substitutions(input)
	end

	def perform_substitutions(input)
		@data[:presubs].each {|s| input.gsub!(s[0], s[1]) }
		input
	end

	def best_sentence(input)
		hot_words = @data[:responses].keys.select do |k|
			k.class == String  && k =~ /^\w+$/
		end
		Wordplay.best_senteces(input.sentences , hot_words)
	end

	def possible_responses(sentence)
		responses = []
		@data[:responses].keys.each do |pattern|
			next unless pattern.is_a?(String)
			if sentence.match('\b' + pattern.gsub(/\*/, ' ') + '\b')
				if pattern.include?('*')
					responses << @data[:responses][pattern].collect do |pharse|
						matching_section = sentence.sub(/^.*#{pattern}\s+/, ' ')
						pharse.sub('*', Wordplay(switch_pronouns(matching_section)))
			        end
			    else    
	                responses << @data[:responses][pattern]
	            end
	        end
	    end
	    responses << @data[:responses][:default] if responses.empty?
         responses.flatten
     end
 end
  










