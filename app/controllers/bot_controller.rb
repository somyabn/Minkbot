#require 'pry'

class BotController < ApplicationController

 def message
    #get message from params
    @inputMsg = params[:userInput]
    @user = User.find(params[:id])
    bot = Bot.new(name: "minkbot", data_file: "bot_data")
    # assign response to intance variable called @response
    @response = bot.response_to(@inputMsg)
   
 end

 def index

 end

end
