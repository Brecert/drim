require 'drim/tail'

module Drim
	class Listener
		def initialize(filename, checktime: 1)

			# @tail = Drim::Tail.new(filename)
			@filename = filename
			@listening = false

			@checktime = checktime

			Thread.abort_on_exception = true
			@threads = []
		end

		def listen(checktime = @checktime)
			@threads << Thread.new do
				tail = Drim::Tail.new(@filename)
				while @listening
					if tail.modified?
						read = tail.read
						yield read
						tail.update
					end
					sleep checktime
				end
			end
		end

		def start()
			@listening = true
		end

		def stop
			@listening = false
		end

		def exit
			@threads.each do |thread|
				thread.exit
			end
		end
	end
end