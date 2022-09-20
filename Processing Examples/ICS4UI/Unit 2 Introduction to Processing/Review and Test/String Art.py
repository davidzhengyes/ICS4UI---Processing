#SETTING UP THE SCREEN
from tkinter import *
from math import *
root = Tk()
screen = Canvas( root, width=1200, height=800, background = "black" )
screen.pack()


#GLOBAL VARIABLES
n = 12   #number of dots
R = 300  #radius of the main ring
r = 10   #radius of a dot

xC = 600 #(x,y) coordinates of the centre of the ring
yC = 400

xValues = []  #empty arrays for storing the dots' x-y coordinates
yValues = []


#MAIN PROGRAM
def mainProgram():
    deltaTheta = 2*pi/n
    angle = 0
    
    for i in range( n ):
        #The (x,y) coordinates of the current dot.
        currX = xC + R*cos( angle ) 
        curry = yC - R*sin( angle )

        #Fills the array with the coordinates just computed
        xValues.append( currX )
        yValues.append( curry )

        angle = angle + deltaTheta

    print("Setup is complete. Drawing can now begin.")
    drawThePicture()


#DRAWS TO THE SCREEN
def drawThePicture():

    #draws the lines
    for i in range( n ):
        print("Drawing lines from dot number", i)
        for j in range( n ):
            screen.create_line( xValues[i], yValues[i], xValues[j], yValues[j], fill="yellow")

    #draws the dots
    for i in range( n ):
        if i < n/4:
            color = "red"

        elif n/4 <= i < n/2:
            color = "white"

        elif n/2 <= i < 3*n/4:
            color = "purple"

        else:
            color = "cyan"

        screen.create_oval( xValues[i]-r, yValues[i]-r, xValues[i]+r, yValues[i]+r, fill = color )



mainProgram()
