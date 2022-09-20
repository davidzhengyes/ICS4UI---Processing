from tkinter import *
from random import *
from time import*
from math import*
myInterface = Tk()
s = Canvas(myInterface, width=900, height=900, background="black")
s.pack()

n = 3.1
rDot = 4
r = (450-rDot*2)/(n+2)
R = n*r
waitTime = 1

numRevolutions = R/r
Rr = R + r
e = r/R

w = 0.1

xM = 450
yM = 450
theta = 0
theta2 = theta - pi
colors=["yellow","red","yellow","lawn green","dark green","cyan","blue","purple"]
L = len(colors)
thetaMax = 4*numRevolutions * 2*pi

f = 0
disk = s.create_oval( xM-R, yM-R, xM+R, yM+R, fill="chocolate")

while theta <= thetaMax:
    phi = e*theta
    
    xC = xM + Rr*cos(phi)
    yC = yM + Rr*sin(phi)
    
    xDot = xC + r*cos(theta)
    yDot = yC + r*sin(theta)
    
    xDot2 = xC + r*cos(theta2)
    yDot2 = yC + r*sin(theta2)

    coin = s.create_oval( xC-r, yC-r, xC+r, yC+r, fill="blue")
    spoke = s.create_line( xDot, yDot, xDot2, yDot2, fill="white", width=1)

    dot1 = s.create_oval(xDot-rDot, yDot-rDot, xDot+rDot, yDot+rDot, fill=colors[0], outline=colors[0])
    dot2 = s.create_oval(xDot2-rDot,yDot2-rDot,xDot2+rDot,yDot2+rDot, fill=colors[1], outline=colors[1])

    theta = (theta + w)
    theta2 = (theta - pi)

    s.update()
    
    if f == 0:  
        sleep(waitTime)
    else:
        sleep(0.03)
        
    s.delete(coin)

    f = f + 1
    
print("done")
s.update()
s.delete(coin, disk)
s.update()
