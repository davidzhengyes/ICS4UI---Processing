import turtle

#SETS UP THE ROBOT. NO NEED TO READ THIS PART.
smartRobot = turtle.Pen()
smartRobot.hideturtle()
smartRobot.penup()
smartRobot.color("red")
smartRobot.shape("turtle")
smartRobot.shapesize(2,2,1)
smartRobot.speed(20)
smartRobot.setpos(-200,200)
smartRobot.showturtle()
smartRobot.pendown()

#YOU MAY ADJUST THE SPEED OF THE ROBOT HERE. 1-9 IS TYPICAL
smartRobot.speed(3) 

#PROBLEM SIZE
n = 5   #Dimension of the grid
s = 70  #Side length of the small squares, measured in pixels

#CONSTANTS. DON'T CHANGE THESE VALUES
angle = 90     #How much the robot turns by, measured in degrees
direction = 1  #1 means "right", -1 means "left"

#DRAWS THE HORIZONTAL LINES
for row in range( n ):
      
      smartRobot.forward( n*s ) #Draws 1 complete horizontal line
      
      smartRobot.right( angle ) #Moves to the next row
      smartRobot.forward( s )
      
      smartRobot.right( angle ) #Gets oriented to draw the next row, but in the opposite direction
      direction = direction * (-1)
      angle = angle*-1

#SWITCHES ORIENTATION TO DRAW THE VERTICAL LINES
smartRobot.forward( s )
angle = angle*(-1)
smartRobot.right( angle )

#DRAWS THE VERTICAL LINES
for col in range( n ):
      
      smartRobot.forward( n*s ) #Draws 1 complete vertical line

      #Moves to the next column and reverses direction 
      if col < n-1:
            smartRobot.left( angle ) 
            smartRobot.forward( s )
            smartRobot.left( angle ) 
            direction = direction * (-1)
            angle = angle*(-1)
      
#FINISHES THE BOUNDARY
smartRobot.right( angle )
smartRobot.forward( n*s )
smartRobot.right( angle )
smartRobot.forward( n*s )

if n % 2 == 1: #if n is odd, we have to paint one more long edge
      smartRobot.right( angle )
      smartRobot.forward( n*s )
      
