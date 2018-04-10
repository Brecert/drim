module Drim::Event
	class Generic
		attr_reader :text, :time, :thread, :type, :response

		def initialize(bot, line)

			# regex_time = '(?<time>\d{2}:\d{2}:\d{2})'
			# regex_thread = '(?<thread>[\w\W]+?)'
			# regex_type = '(?<type>\w+)'
			# regex_response = '(?<response>.+)'
			regex = Regexp.new(/^\[(?<time>\d{2}:\d{2}:\d{2})\] \[(?<thread>[\W\w]*?)\/(?<type>\w+)\]: (?<response>.+)/)

			@bot = bot

			matched = regex.match line
			@text = line
			@time = matched[:time]
			@thread = matched[:thread]
			@type = matched[:type]
			@response = matched[:response]
		end
	end
end