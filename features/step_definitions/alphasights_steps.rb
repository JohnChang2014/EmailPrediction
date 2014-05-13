class Output 
	def messages
    	@messages ||= []
	end
	
	def puts(message) 
		messages << message
	end 
end

def output
	@output ||= Output.new
end

Given(/^I am not yet starting$/) do
end

When(/^I start the app$/) do
	@predictor = Alphasights::EmailPredictor.new(output)
	@predictor.start
end

Then(/^I should see "(.*?)"$/) do |arg1|
  	output.messages.should include(arg1)
end