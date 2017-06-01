Feature: Robot reporting
  Scenario: Robot ignores REPORT command prior to placement
    Given I am a robot
    And I receive command REPORT
    Then I out nothing
  Scenario: Robot reports his position after movement
    Given I am a robot
    And I receive command "PLACE 0,0,NORTH"
    And I receive command MOVE
    And I receive command REPORT
    Then I out "0,1,NORTH"
