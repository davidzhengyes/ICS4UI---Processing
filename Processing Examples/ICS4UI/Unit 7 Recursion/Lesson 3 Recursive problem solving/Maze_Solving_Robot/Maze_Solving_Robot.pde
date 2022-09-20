Maze maze;
Robot robot;
int robotSpeed = 2;
int stepNumber = 0;


void setup() {
  size(500, 500);
  background(0);
  frameRate( robotSpeed );
  
  maze = new Maze( 7, 6 ); //Create an empty 7x6 maze

  maze.digColumn(0, 2, 3); //Fill column 0 from rows 2-3
  maze.digColumn(1);       //Fill all of column 1
  maze.digColumn(4, 0, 2); //Fill column 4 from rows 0-2
  maze.digRow(2, 1, 5);    //Fill row 2 from columns 1-5
  maze.digRow(5, 1, 6);    //Fill row 4 from columns 1-6
  //maze.digRow(3, 4, 5); 
  //maze.digRow(4, 4, 5); 
  maze.setExit(0, 4);      //The exit is is row 0, column 4

  robot = new Robot( maze );
  robot.setPosition(0, 1, "down" );  //Robot starts in row 0, column 1, heading down
  
  maze.drawMe();

  solveMaze();  //Solves the maze and stores the robot's path before draw() starts running the animation
}    


void solveMaze() {
  if ( robot.atExit() )  //BASE CASE: WE'RE AT THE EXIT
    println("FOUND THE EXIT!");

  else {                 //RECURSIVE CASE:  USE THE RIGHT-HAND RULE TO DETERMINE
                         //                 THE NEXT DIRECTION TO MOVE IN, THEN TAKE 1 STEP
    if ( robot.canTurnRight() ) {
      robot.turnRight();
    } 
    
    else if (robot.canGoStraight()) {
      //Do nothing
    }

    else if (robot.canTurnLeft()) {
      robot.turnLeft();
    } 
    
    else {
      robot.turnAround();
    }
    
    robot.forwardOneStep();
    solveMaze(); //Recursive procedure-call.  By now, the robot has changed its location and/or direction
  }
} 


void draw() {
  if( stepNumber < robot.path.size() ) {
    background(0);
    maze.drawMe();
    robot.drawMe( stepNumber ); 
    stepNumber++;
  }
}
