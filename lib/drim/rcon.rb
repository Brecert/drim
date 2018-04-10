module Drim
	class Rcon
		attr_accessor :rcon

		def initialize(bot, host, port, password)
			@bot = bot
			@host = host
			@port = port
			@password = password

			@rcon = Zrcon.new host: @host, port: @port, password: @password
			@rcon.auth
		end

		def tellraw(user, message, *params)
			textcomponent = {
				"text": message.chomp
			}
			# p textcomponent
			# textcomponent
			params.each do |param|
				textcomponent.merge! param
			end
			# textcomponent = textcomponent[:text].unpack("U*").map{|i| '\u' + i.to_s(16).rjust(4, '0')}.join
			# textcomponent.each do |key, value|
				# puts textcomponent[key] = value.unpack("U*").map{|i| "" + i.to_s(16).rjust(4, '0')}.join
			# end
			puts textcomponent
			# textcomponent = textcomponent.to_json
			# puts textcomponent
			p textcomponent.to_json
			puts "Final: tellraw #{user} " + textcomponent.to_json
			@rcon.command "tellraw #{user} " + textcomponent.to_json 
		end
# unpack("U*").map{|i| i.to_s(16).rjust(4, '0')}.join
		def command(string)
			@rcon.command string
		end

	end
end