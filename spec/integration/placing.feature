Feature: Robot placing
  Scenario: PLACE will put the toy robot on the table in position X , Y and facing NORTH , SOUTH , EAST or WEST
    Given I am a robot
    And I receive command "PLACE 0,0,NORTH"
    And I receive command REPORT
    Then I out "0,0,NORTH"
  Scenario: The first valid command to the robot is a PLACE command. Any other command after PLACE is valid
    Given I am a robot
    And I receive command REPORT
    And I receive command "PLACE 0,0,NORTH"
    And I receive command REPORT
    Then I out "0,0,NORTH"
