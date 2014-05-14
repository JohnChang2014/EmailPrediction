Feature: user submits one of choices
  The user has different actions to take: one is choosing one of default test sample, another is asking for typing 
  advisor's name and the domain name of the company he work work, and the other is exiting email predictor.
  
  For the first action, the user may get three kind of result: one potential email, multiple emails, or no answer.
  The result depends on whether the domain name exists in the dataset of email predictor. If the domain name exists,
  then the predictor will output potential emails. Otherwise, no answer to tell.
  
  Scenario Outline: submit one of default test samples
    Given the sample dataset of pattern
    When I submit one of default test samples "<number>"
    Then the result should be "<result>"
      
    Scenarios: only one potential email
      | number | result |
      |   1    | peter.wong@alphasights.com |
    
    Scenarios: multiple potential emails
      | number | result |
      |   2    | craig.s@google.com, c.silverstein@google.com |
    
    Scenarios: no answer
      | number | result |
      |   4    | no answer to tell |
      
  Scenario: ask for typing info
    Given the sample dataset of pattern
    When I submit the fifth option "5"
    Then I should see "Enter Advisor's name and domain name (ex: john chang, alphasights.com):" 