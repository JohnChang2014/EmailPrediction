Feature: user starts email predictor
  As a user
  I want to start email predictor
  so that I can get potential email addresses
  
  Scenario: start email predictor
    Given I am not yet starting
    When I start the app
    Then I should see "Welcome to Email Predictor"
    And I should see "Choose one of test samples below:"
    And I should see "1.  Peter Wong, alphasights.com"
	And I should see "2.  Craig Silverstein, google.com"
	And I should see "3.  Steve Wozniak, apple.com"
	And I should see "4.  Barack Obama, whitehouse.gov"
	And I should see "5.  Enter other sample..."