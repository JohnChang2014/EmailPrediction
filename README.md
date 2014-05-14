# Email Prediction

The project is implemented with Behavior Driven Development (BDD), using RSpec and Cucumber.
All files of features and step definitions are located in the directory of features, while all spec files are in the 
directory of spec. Sample dataset is revised in the form of json and the file is in the directory of data.

## Installation && Dependencies
To run this program, you may need to install 'json' gem.
    
    gem install json
    
The development environment of the project is based on Ruby 2.0, RSpec 2.14.8 and Cucumber 1.3.15. 
If you'd to run spec and features files for testing results, make sure you already have RSpec and Cucumber installed.
If not, try the commands below: 

    gem install rspec -v ">= 2.14.8"
    gem install cucumber -v ">= 1.3.15"

## How to Run Program
There is an executable script in the directory of bin named 'emailpredictor'. Below shows the source of the script

```ruby
#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'alphasights'

predictor = Alphasights::EmailPredictor.new(STDOUT)
matcher   = Alphasights::PatternMatcher.new(STDOUT).initPatternList('data/sample.json')
predictor.start(matcher)
while true
    input = STDIN.gets
    predictor.submit input
end
```

To run this program, please open your terminal and then do the commands below:

    cd path-to-the project folder
    bin/emailpredictor
    
After that, you will see the messages below, which means the program is executed successfully.

    Welcome to Email Predictor
    Choose one of test samples below:
    1.  Peter Wong, alphasights.com
    2.  Craig Silverstein, google.com
    3.  Steve Wozniak, apple.com
    4.  Barack Obama, whitehouse.gov
    5.  Or enter Advisor's name and domain name (ex: john chang, alphasights.com):
    6.  Type in '6' to exit
    
## Usage of the Program
With the above messages, you can simply do as below:
To test default sample data, type in 1 to 4. For example, try 1 and you will get:
    
    a pattern matched
    peter.wong@alphasights.com

To try specific example, you can enter a string in the format like 'first_name last_name, domain name'.
For example, try "john chang, alphasights.com" and you will see:

    a pattern matched
    john.chang@alphasights.com

To terminate the program, just enter 6.

    Thanks you. Bye Bye!
