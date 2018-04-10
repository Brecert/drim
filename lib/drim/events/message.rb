require 'Drim/user'
require 'Drim/events/generic'

module Drim::Event

	class Message < Drim::Event::Generic

		attr_reader :username, :message

		def initialize(bot, line)
			super
			response_matched = Regexp.new(@bot.chat_format % {username: @bot.regex_username, message: @bot.regex_message}).match(@response)
			@username = response_matched[:username]
			@message = response_matched[:message]
		end

		def user
			Drim::User.new @bot, @username
		end
	end
end