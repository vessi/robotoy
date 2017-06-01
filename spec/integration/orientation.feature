Feature: Robot orientation
  Scenario: LEFT will rotate 90 degrees in the specified direction w/o changing the position of the robot
    Given I am a robot
    And I receive command "PLACE 0,0,NORTH"
    And I receive command LEFT
    And I receive command REPORT
    Then I out "0,0,WEST"
  Scenario: RIGHT will rotate 90 degrees in the specified direction w/o changing the position of the robot
    Given I am a robot
    And I receive command "PLACE 0,0,NORTH"
    And I receive command RIGHT
    And I receive command REPORT
    Then I out "0,0,EAST"
