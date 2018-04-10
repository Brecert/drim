require 'Drim/events/generic'

module Drim::Event

	class MinecraftEvent < Drim::Event::Generic

		attr_reader :username, :message

		def initialize(bot, line)
			super
			response_matched = Regexp.new(/\[(?<username>.+?): (?<message>.+?)\]/).match(@response)
			@username = response_matched[:username]
			@message = response_matched[:message]
		end

		def user
			Drim::User.new @bot, @username
		end
	end
end