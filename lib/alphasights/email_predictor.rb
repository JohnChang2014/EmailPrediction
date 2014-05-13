module Alphasights
	class EmailPredictor
		def initialize(output)
			@output = output
		end

		def start
			@output.puts 'Welcome to Email Predictor'
			@output.puts 'Choose one of test samples below:'
			@output.puts '1.  Peter Wong, alphasights.com'
			@output.puts '2.  Craig Silverstein, google.com'
			@output.puts '3.  Steve Wozniak, apple.com'
			@output.puts '4.  Barack Obama, whitehouse.gov'
			@output.puts '5.  Enter other sample...'
		end
	end
end