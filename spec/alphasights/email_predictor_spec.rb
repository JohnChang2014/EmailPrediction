require 'spec_helper'

module Alphasights
	describe "#start" do
		let(:output) { double('output').as_null_object }
		let(:predictor) { EmailPredictor.new(output) }
		
		it "shows welcome message" do
			output.should_receive(:puts).with('Welcome to Email Predictor') 
			predictor.start
		end
		
		it "prompts for users to choose test samples" do
			output.should_receive(:puts).with('Choose one of test samples below:')
			predictor.start
		end
		
		it "prompts the first choice of test sample" do
			output.should_receive(:puts).with('1.  Peter Wong, alphasights.com')
			predictor.start
		end
		
		it "prompts the second choice of test sample" do
			output.should_receive(:puts).with('2.  Craig Silverstein, google.com')
			predictor.start
		end
		
		it "prompts the third choice of test sample" do
			output.should_receive(:puts).with('3.  Steve Wozniak, apple.com')
			predictor.start
		end
		
		it "prompts the fourth choice of test sample"  do
			output.should_receive(:puts).with('4.  Barack Obama, whitehouse.gov')
			predictor.start
		end
		
		it "prompts the fifth choice to enter other test sample" do
			output.should_receive(:puts).with('5.  Enter other sample...')
			predictor.start
		end
	end
end