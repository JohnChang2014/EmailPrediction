require 'json'

module Alphasights
	class EmailPredictor
		def initialize(output)
			@output   = output
			@options = ['Peter Wong, alphasights.com', 'Craig Silverstein, google.com', 'Steve Wozniak, apple.com', 'Barack Obama, whitehouse.gov', 'Enter other sample...']
		end

		def start(matcher)
			@matcher = matcher
			@output.puts 'Welcome to Email Predictor'
			@output.puts 'Choose one of test samples below:'
			@options.each_with_index {|s, index| @output.puts "#{index+1}.  #{s}" }
		end
		
		def submit(number)
			number = number.to_i
			if number >= 1 && number <= 4
				input   = @options[number-1]
				pattern = @matcher.find(input)
				@matcher.potentialEmails(input, pattern)
			elsif number == 5
				@output.puts "Enter Advisor's name and domain name (ex: john chang, alphasights.com):"
			end
		end
	end
	
	class PatternMatcher
		attr_accessor :dataset, :plist
		
		def initialize(output)
			@output = output 
		end
		
		def initPatternList(path)
			createPatternList if loadSample(path)
			self
		end
		
		def loadSample(path)
			if File.exist? path
				json     = File.read(path)
				@dataset = JSON.parse(json)
				true
			else
				@output.puts 'the file not existing'
				false
			end
		end
		
		def createPatternList
			@plist = @dataset.values.group_by{ |e| e.split('@')[1] }.each_pair{ |k,v| v.map!{ |e| recognize(e) }.uniq! }
		end
		
		def find(target)
			target = target.split(/,\s?/)
			domain = target[1]
			result = @plist[domain]
			if result.nil?
			elsif result.length == 1
				@output.puts 'a pattern matched'
			elsif result.length > 1
				@output.puts 'multiple pattern matched'
			end
			result
		end
		
		def potentialEmails(input, pattern)
			if pattern.nil?
				@output.puts 'no answer to tell'
			else
				input = input.split(/,\s?/)
				@output.puts namePattern(input[0], pattern).map!{|name| "#{name}@#{input[1]}"}.join(', ')
			end
		end
		
		private
			def recognize(address)
				name = address.gsub(/@.+/, '').split('.')
				if name.first.length > 1 and name.last.length > 1
					1 # first_name_dot_last_name
				elsif name.first.length > 1 and name.last.length == 1
					2 # first_name_dot_last_initial
				elsif name.first.length == 1 and name.last.length > 1
					3 # first_initial_dot_last_name
				elsif name.first.length == 1 and name.last.length == 1
					4 # first_initial_dot_last_initial
				end
			end
			
			def namePattern(name, pattern)
				patterns = []
				name = name.split(/\s/).map!(&:downcase)
				# first_name_dot_last_name
				patterns << name.join('.') if pattern.include? 1
				# first_name_dot_last_initial
				patterns << name[0] + '.' + name[1][0] if pattern.include? 2
				# first_initial_dot_last_name
				patterns << name[0][0] + '.' + name[1] if pattern.include? 3
				# first_initial_dot_last_initial
				patterns << name.map{|e| e[0] }.join('.') if pattern.include? 4
				patterns
			end
	end
end