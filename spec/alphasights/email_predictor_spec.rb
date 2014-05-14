require 'spec_helper'

module Alphasights
	describe EmailPredictor do
		let(:output) { double('output').as_null_object }
		let(:predictor) { EmailPredictor.new(output) }
		let(:matcher) { PatternMatcher.new(output).initPatternList('data/sample.json') }

		describe "#start" do
			it "shows welcome message" do
				output.should_receive(:puts).with('Welcome to Email Predictor')
				predictor.start(matcher)
			end

			it "prompts for users to choose test samples" do
				output.should_receive(:puts).with('Choose one of test samples below:')
				predictor.start(matcher)
			end

			it "prompts the first choice of test sample" do
				output.should_receive(:puts).with('1.  Peter Wong, alphasights.com')
				predictor.start(matcher)
			end

			it "prompts the second choice of test sample" do
				output.should_receive(:puts).with('2.  Craig Silverstein, google.com')
				predictor.start(matcher)
			end

			it "prompts the third choice of test sample" do
				output.should_receive(:puts).with('3.  Steve Wozniak, apple.com')
				predictor.start(matcher)
			end

			it "prompts the fourth choice of test sample"  do
				output.should_receive(:puts).with('4.  Barack Obama, whitehouse.gov')
				predictor.start(matcher)
			end

			it "prompts the fifth choice to enter other test sample" do
				output.should_receive(:puts).with('5.  Enter other sample...')
				predictor.start(matcher)
			end
		end

		describe "#submit" do
			context "with one of four default samples" do
				context "has only one potential email" do
					it "return a message with the email" do
						output.should_receive(:puts).with('peter.wong@alphasights.com')
						predictor.start(matcher)
						predictor.submit('1')
					end
				end

				context "with multiple potential emails" do
					it "return a message with the email" do
						output.should_receive(:puts).with('craig.s@google.com, c.silverstein@google.com')
						predictor.start(matcher)
						predictor.submit('2')
					end
				end

				context "with no potential email" do
					it "sends a message saying no answer to tell" do
						output.should_receive(:puts).with('no answer to tell')
						predictor.start(matcher)
						predictor.submit('4')
					end
				end
			end
			
			context "with the fifth option" do
				it "prompts a message asking for advisor's name and domain" do
					output.should_receive(:puts).with("Enter Advisor's name and domain name (ex: john chang, alphasights.com):")
					predictor.start(matcher)
					predictor.submit('5')
				end
			end
		end
	end
end