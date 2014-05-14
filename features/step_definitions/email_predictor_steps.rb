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
	@matcher = Alphasights::PatternMatcher.new(output)
	@predictor.start(@matcher)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  	output.messages.should include(arg1)
end

Given(/^the sample dataset of pattern$/) do
	@predictor = Alphasights::EmailPredictor.new(output)
	path = 'data/sample.json'
	@matcher = Alphasights::PatternMatcher.new(output).initPatternList(path)
	@predictor.start(@matcher)
end

When(/^I submit one of default test samples "(.*?)"$/) do |arg1|
  	@predictor.submit(arg1)
end

Then(/^the result should be "(.*?)"$/) do |arg1|
  	output.messages.should include(arg1)
end

When(/^I submit the fifth option "(.*?)"$/) do |arg1|
  	@predictor.submit(arg1)
end