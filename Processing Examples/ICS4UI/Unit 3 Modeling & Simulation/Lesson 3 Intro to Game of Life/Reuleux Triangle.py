from tkinter import *
from time import *
from math import *
tk = Tk()
s = Canvas(tk, width=800,height=800, background="black")
s.pack()

xC = 400
yC = 400
r = 200
R = 2*r*cos(pi/6)
gMax = R-r
gMin = R/2
gDiff = (gMax-gMin)/2
gAvg  = (gMax+gMin)/2
yGround = 600

x = []
y = []

gap = 2*pi/3
angle = 0
angleDegrees = 0

def g(t):
      z = gDiff*cos(3*t)+gAvg
      return z

a=[]
b=[]
os = 0
c = 10
c1="red"
c2="blue"
c3="green"
if angle <= pi/3:
      yC = yGround - g(angle)
      for i in range(3):
            theta = i*gap+angle
            x = xC+r*cos(theta)
            y = yC-r*sin(theta)
            a.append(x)
            b.append(y)           
      s.create_arc(a[0]-R-os, b[0]-R, a[0]+R-os, b[0]+R, start=(angleDegrees+150+0*120)%360, extent=60, fill=c2, outline=c2)
      s.create_arc(a[1]-R, b[1]-R+os, a[1]+R, b[1]+R+os, start=(angleDegrees+150+1*120)%360, extent=60, fill=c2, outline=c2)
      s.create_arc(a[2]-R+os, b[2]-R-os, a[2]+R+os, b[2]+R-os, start=(angleDegrees+150+2*120)%360, extent=60, fill=c2, outline=c2)
      for i in range(3):
            s.create_oval(a[i]-c, b[i]-c, a[i]+c, b[i]+c, fill="yellow")
      s.create_text(400,450,text="A very cool shape", fill="yellow")
      s.update()
##      sleep(0.03)
##      s.delete("all")

 #     angle -= .01
      angleDegrees = degrees(angle)

s.update()
