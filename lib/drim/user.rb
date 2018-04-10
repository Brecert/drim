module Drim
	class User
		attr_reader :username

		def initialize(bot, username)
			@bot = bot
			@username = username
		end

		#TODO: UUID

		def tell(message)
			@bot.tell(@username, message)
		end

		def whisper(message)
			@bot.whisper(@username, message)
		end
		alias :w :whisper

		#TODO: Execute
	end
end