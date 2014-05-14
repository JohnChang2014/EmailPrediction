require 'spec_helper'

module Alphasights
	describe PatternMatcher do
		let(:output) { double('output').as_null_object }
		let(:path) { 'data/sample.json' }
		let(:matcher) { PatternMatcher.new(output) }

		describe "#loadSample" do
			context "with file loaded successfully" do
				it "populates dataset from the file" do
					matcher.loadSample(path)
					matcher.dataset.should_not be_nil
				end

				it "returns true" do
					matcher.loadSample(path).should be_true
				end
			end

			context "with file loaded not successfully" do
				it "sends a message saying file not existing" do
					output.should_receive(:puts).with('the file not existing')
					path = 'data1/sample.json'
					matcher.loadSample(path)
				end

				it "returns false" do
					path = 'data1/sample.json'
					matcher.loadSample(path).should be_false
				end
			end
		end

		describe "#createPatternList" do
			context "with default sample dataset" do
				it "returns hash-like list with domain name as key and an array of numbers as value" do
					matcher.loadSample(path)
					matcher.createPatternList.should eq({ "alphasights.com"=>[1], "google.com"=>[2, 3], "apple.com"=>[4] })
				end
			end
		end

		describe "#find" do
			before(:each) do
				matcher.createPatternList if matcher.loadSample(path)
			end

			context "with one pattern matched" do
				let(:target) { "John Chang, alphasights.com" }
				it "sends a message saying found a pattern matched" do
					output.should_receive(:puts).with('a pattern matched')
					matcher.find(target)
				end

				it "returns an array with one number representing one of four name patterns" do
					matcher.find(target).should eq([1])
				end
			end

			context "with multiple patterns matched" do
				let(:target) { "John Chang, google.com" }
				it "sends a message saying multiple patterns matched" do
					output.should_receive(:puts).with('multiple pattern matched')
					matcher.find(target)
				end

				it "returns an array with multiple numbers representing more than one of four name patterns" do
					matcher.find(target).should eq([2,3])
				end
			end

			context "with no pattern matched" do
				it "sends a message saying no pattern matched"
				it "returns nil"
			end
		end

		describe "#potentialEmails" do
			let(:input) { "John Chang, alphasights.com" }
			
			context "with one pattern matched" do
				context "in the form of first_name_dot_last_name" do
					it "returns one potential email in the format" do
						output.should_receive(:puts).with('john.chang@alphasights.com')
						pattern = [1]
						matcher.potentialEmails(input, pattern)
					end
				end
				
				context "in the form of first_name_dot_last_initial" do
					it "returns one potential email in the format" do
						output.should_receive(:puts).with('john.c@alphasights.com')
						pattern = [2]
						matcher.potentialEmails(input, pattern)
					end
				end
				
				context "in the form of first_initial_dot_last_name" do
					it "returns one potential email in the format" do
						output.should_receive(:puts).with('j.chang@alphasights.com')
						pattern = [3]
						matcher.potentialEmails(input, pattern)
					end
				end
				
				context "in the form of first_initial_dot_last_initial" do
					it "returns one potential email in the format" do
						output.should_receive(:puts).with('j.c@alphasights.com')
						pattern = [4]
						matcher.potentialEmails(input, pattern)
					end
				end
			end
			
			context "with multiple pattern matched" do
				it "returns multiple potential emails in the related format" do
					output.should_receive(:puts).with('john.chang@alphasights.com, john.c@alphasights.com')
					pattern = [1,2]
					matcher.potentialEmails(input, pattern)
				end
			end
			
			context "with no pattern matched" do
				it "send a message saying no answer to tell" do
					output.should_receive(:puts).with('no answer to tell')
					pattern = nil
					matcher.potentialEmails(input, pattern)
				end
			end
		end
	end
end