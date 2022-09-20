import turtle

#SETS UP THE ROBOT. NO NEED TO READ THIS PART.
dumbRobot = turtle.Pen()
dumbRobot.hideturtle()
dumbRobot.penup()
dumbRobot.color("blue")
dumbRobot.shape("turtle")
dumbRobot.shapesize(2,2,1)
dumbRobot.speed(20)
dumbRobot.setpos(-200,200)
dumbRobot.showturtle()
dumbRobot.pendown()

#YOU MAY ADJUST THE SPEED OF THE ROBOT HERE. 1-9 IS TYPICAL
dumbRobot.speed(5)

#PROBLEM SIZE
n = 5   #Dimension of the grid
s = 70  #Side length of the small squares, measured in pixels

#CONSTANTS. DON'T CHANGE THESE VALUES
angle = 90     #How much the robot turns by, measured in degrees

#DRAWS THE GRID IN A DUMB WAY
for row in range( n ):

      for col in range( n ):
            
                  #Draws one small box
                  for x in range( 4 ):
                       dumbRobot.forward( s )
                       dumbRobot.right( angle )

                  #Moves one column over to start the next box
                  dumbRobot.forward( s )

      #After finishing this row,
      #the robot moves down 1 row and reverses the orientation of its turning
      #so that it draws the next row in the opposite direction
      dumbRobot.right( angle )
      dumbRobot.forward( s ) 
      dumbRobot.right( angle ) 
      angle = angle*(-1) 
                                          
