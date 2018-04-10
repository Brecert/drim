module Drim
	class Tail
		attr_reader :lastline

		def initialize(filename)
			@filename = filename
			@file = File.new(@filename, "r")
			@lastline = @file.readlines(chomp: true).last

			self.update
		end

		def read
			last_lines = []
			@file.each_line do |line|
				line
				last_lines << line
				@lastline = line
			end

			last_lines
		end

		def update
			@stat = @file.stat
		end

		def modified?
			i = @stat <=> @file.stat
			if i === 0
				false
			else
				true
			end
		end
	end
end