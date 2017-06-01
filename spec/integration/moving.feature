Feature: Robot moving
  Scenario: MOVE will move the toy robot one unit forward in the direction it is currently facing.
    Given I am a robot
    And I receive command "PLACE 0,0,NORTH"
    And I receive command MOVE
    And I receive command REPORT
    And I out "0,1,NORTH"
  Scenario: Robot must be prevented from falling to destruction
    Given I am a robot
    And I receive command "PLACE 4,0,NORTH"
    And I receive command RIGHT
    And I receive command MOVE
    And I receive command REPORT
    And I out "4,0,EAST"
