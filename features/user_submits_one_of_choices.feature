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
      
  Scenario: submit specific advisor's name and domain in a valid format
    Given the sample dataset of pattern
    When I submit "John Chang, alphasights.com"
    Then I should see "john.chang@alphasights.com" 
    
  Scenario: submit specific advisor's name and domain in an invalid format
    Given the sample dataset of pattern
    When I submit "John Chang alphasights.com"
    Then I should see "you should type in data in the format like 'first_name last_name, domain name'" 