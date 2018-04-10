require 'json'
require 'zrcon'
require 'drim/rcon'
require 'drim/listener'
require 'drim/events'

module Drim
	class Bot
		attr_accessor :name, :log, :chat_format
		attr_reader :host, :port, :password

		# The regex used to match usernames
		REGEX_USERNAME = '(?<username>[\w\d_]{2,18})'.freeze

		# The regex used to match what the player says
		REGEX_MESSAGE = '(?<message>.+)'.freeze

		def regex_username
			REGEX_USERNAME
		end

		def regex_message
			REGEX_MESSAGE
		end

		def initialize(
			host: '0.0.0.0',
			port: 25565,
			password: 'password',
			name: 'Drim',
			log: nil,
			chat_format: '<%{username}> %{message}'
		)
			@host = host
			@port = port
			@password = password
			@name = name
			@log = log
			@listener = Drim::Listener.new @log
			@listener.start

			@chat_format = chat_format

			#TODO: Create new instance inside of modules later.
			@rcon = Drim::Rcon.new self, @host, @port, @password
		end

		def tell(user, message)
			@rcon.tellraw user, "#{@name} tells you: #{message}", color: 'gray', italic: 'true'
		end

		def whisper(user, message)
			@rcon.tellraw user, "#{@name} whispers to you: #{message}", color: 'gray', italic: 'true'
		end

		def command(command)
			@rcon.command command
		end

		def on(type)
			@listener.listen do |lines|
				lines.each do |line|
					tev = Drim::Event::Generic.new @line, line
					case type
					when 'message'
						if Regexp.new(@chat_format % {username: REGEX_USERNAME, message: REGEX_MESSAGE}).match(tev.response)
							yield Drim::Event::Message.new self, line
						end
					when 'event'
						if Regexp.new(/\[(?<username>.+?): (?<message>.+?)\]/).match(tev.response)
							yield Drim::Event::MinecraftEvent.new self, line
						end
					when 'any' || 'generic'
						yield tev
					end
				end
			end
		end

		def exit
			@listener.stop
			@listener.exit
			exit
		end

	end
end