from tkinter import *
from time import *
from math import *
from random import *


tk = Tk()
s = Canvas(tk, width=1000,height=800,background="light blue")
s.pack()

#GROUND
s.create_rectangle(0,550, 1000,800, fill="PaleGreen4", outline="PaleGreen4")

#CLOUDS
for i in range(25):
    x = randint(700,900)
    y = randint(200,300)
    xSize = randint(50,100)
    ySize = randint(20,50)
    s.create_oval(x,y, x+xSize,y+ySize, fill= "white", outline="white")

for i in range(50):
    x = randint(300,550)
    y = randint(50,125)
    xSize = randint(50,100)
    ySize = randint(20,50)
    s.create_oval(x,y, x+xSize,y+ySize, fill= "white", outline="white")

for i in range(50):
    x = randint(10,360)
    y = randint(300,380)
    xSize = randint(50,100)
    ySize = randint(20,50)
    s.create_oval(x,y, x+xSize,y+ySize, fill= "white", outline="white")


#FOREST
for i in range(50):
    x = randint(0,500)
    y = randint(535,560)
    s.create_rectangle(x,y,x+5,y+18, fill="saddle brown", outline = "saddle brown")

for i in range(500):
    x = randint(0,500)
    y = randint(525,555)
    size = randint(5,15)
    colour = choice(["dark green", "forest green"])
    s.create_oval(x-size,y-size, x+size,y+size, fill=colour, outline=colour)

#TOWN
house = []
roof = []

for i in range(10):
    house.append(0)
    roof.append(0)
    x = randint(700, 850)
    y = randint(535, 580)
    roofColour = choice(["LightSalmon2", "LightSalmon3", "LightSalmon4"])
    houseColour = choice(["burlywood1", "burlywood2", "burlywood3"])
    
    house[i] = s.create_rectangle(x,y, x+25,y+15, fill=houseColour, outline = houseColour)
    roof[i] = s.create_polygon(x-8,y+3, x+13,y-8, x+33,y+3, fill=roofColour)

#WIZARD
s.create_line(220,175, 235,265, fill="tan4", width=7)
s.create_oval(372,205, 357,220, fill="bisque", outline="bisque")
s.create_oval(228,205, 243,220, fill="bisque", outline="bisque")
s.create_polygon(235,200, 300,240, 365,200, 365,250, 317,255, 319,300, 281,300, 283,255, 235,250, fill = "blue")
s.create_polygon(288,222, 312,222, 314,235, 313,245, 310,250, 305,242, 300,253, 295,240, 290,245, 286,235,   fill="grey65")
s.create_polygon(300,200, 310,220, 315,225, 285,225, 290,220, fill="blue")

#TOWER
s.create_rectangle(225,300, 375,800, fill="grey70", outline="grey70")

s.create_rectangle(225,290, 240,300, fill="grey70", outline="grey70")
s.create_rectangle(255,290, 275,300, fill="grey70", outline="grey70")
s.create_rectangle(290,290, 310,300, fill="grey70", outline="grey70")
s.create_rectangle(325,290, 345,300, fill="grey70", outline="grey70")
s.create_rectangle(360,290, 375,300, fill="grey70", outline="grey70")

xq = []
yq = []

for r in range(9):
    xq.append(randint(230,325))
    yq.append(randint(310,800))

for i in range(9):
    s.create_rectangle(xq[i],yq[i], xq[i]+50,yq[i]+18, outline="grey55")
    s.update()
    sleep(0.01)
    







## SPIRAL MAGIC ##
numM = 3
amp = 200

newBaseX = 300
baseX = 0
newBaseY = 803
baseY = 803

brick = []
x = []
y = []
size = []
m = []
mb = []
mc = []

for i in range(numM):
    x.append( randint(0,50))
    y.append( randint(0,50))
    size.append( randint(5,16))
    m.append(0)
    mb.append(0)
    mc.append(0)
    for t in range(3):
        brick.append(0)

    
t = 0
while newBaseY > 220:
    t = t + 1

    oldBaseY = baseY
    baseY = newBaseY
    newBaseY = newBaseY - 5
    
    oldBaseX = baseX
    baseX = newBaseX
    newBaseX = 275 + amp*sin( 50*t )

    

    
    for i in range(numM):
        m[i] = s.create_oval(newBaseX+x[i],newBaseY+y[i], newBaseX+x[i]+size[i],newBaseY+y[i]+size[i], fill="red4", outline ="red4")
        mb[i] = s.create_oval(baseX+x[i],baseY+y[i], baseX+x[i]+size[i],baseY+y[i]+size[i], fill="red3", outline ="red3")
        mc[i] = s.create_oval(oldBaseX+x[i],oldBaseY+y[i], oldBaseX+x[i]+size[i],oldBaseY+y[i]+size[i], fill="red2", outline ="red2")

    if baseX > oldBaseX - 10:
        tower = s.create_rectangle(225,300, 375,800, fill="grey70", outline="grey70")
        towerBit1 = s.create_rectangle(225,290, 240,300, fill="grey70", outline="grey70")
        towerBit2 = s.create_rectangle(255,290, 275,300, fill="grey70", outline="grey70")
        towerBit3 = s.create_rectangle(290,290, 310,300, fill="grey70", outline="grey70")
        towerBit4 = s.create_rectangle(325,290, 345,300, fill="grey70", outline="grey70")
        towerBit5 = s.create_rectangle(360,290, 375,300, fill="grey70", outline="grey70")
        
        for iBricks in range(numM*3):
            brick[iBricks] = s.create_rectangle(xq[iBricks],yq[iBricks], xq[iBricks]+50,yq[iBricks]+18, outline="grey40")
                


            
    s.update()
    sleep(0.01)

    for i in range(numM):
        s.delete(m[i], mb[i], mc[i],tower,towerBit1,towerBit2,towerBit3,towerBit4,towerBit5)

    for i in range(numM*3):
        s.delete(brick[i])
    
    amp = amp - 0.5


    

## COLLECTING MAGIC ##

x = []
y = []
xSpeed = []
ySpeed = []
size = []
m = []

for i in range(20):
    xa = randint(0,600)
    x.append(xa)
    ya = randint(-500,600)
    y.append(ya)
    size.append( randint(5,20))
    xSpeed.append((300 - xa)/20)
    ySpeed.append((100 - ya)/20)
    m.append(0)


for f in range(20):
    for i in range(len(x)): 
        m[i] = s.create_oval(x[i],y[i], x[i]+size[i],y[i]+size[i], fill="red3", outline="red3")

        xb = x[i]
        yb = y[i]
        xs = xSpeed[i]
        ys = ySpeed[i]
        x[i] = xb + xs
        y[i] = yb + ys


        if 293 <= x[i] <= 307 and 93 <= y[i] <= 107:
            xSpeed[i] = 0
            ySpeed[i] = 0


    s.update()
    sleep(0.03)
    for i in range(len(x)):
        s.delete(m[i])




## MAGIC ORB ##

radius = []
xc = 300
yc = 100
c = []

for f in range(8):
    radius.append(0)
    c.append(0)

for f in range(8):
    for i in range(8):
        c[i] = s.create_oval(xc-radius[i],yc-radius[i], xc+radius[i],yc+radius[i], fill = "#%02x%02x%02x" % (30+25*i, 0, 30), outline = "#%02x%02x%02x" % (30+25*i, 0, 30))

    if f < 7:
        radius[7-f] = 120 + 15*(f -8)
    s.update()
    time = (randint(1, 50))/100
    sleep(time)
    for i in range (8):
        s.delete(c[i])







sleep(0.8)

## LASER BEAM ##
laser = s.create_polygon(340,30, 225,125, 788,563, fill="red3")

orb = []
for i in range(8):
    orb.append(0)
    orb[i] = s.create_oval(xc-radius[i],yc-radius[i], xc+radius[i],yc+radius[i], fill = "#%02x%02x%02x" % (30+25*i, 0, 30), outline = "#%02x%02x%02x" % (30+25*i, 0, 30))

#remaking the things
hand = s.create_oval(372,205, 357,220, fill="bisque", outline="bisque")
robe = s.create_polygon(235,200, 300,240, 365,200, 365,250, 317,255, 319,300, 281,300, 283,255, 235,250, fill = "blue")
hair = s.create_polygon(288,222, 312,222, 314,235, 313,245, 310,250, 305,242, 300,253, 295,240, 290,245, 286,235,   fill="grey65")
hat = s.create_polygon(300,200, 310,220, 315,225, 285,225, 290,220, fill="blue")
towerBit = s.create_rectangle(290,290, 310,300, fill="grey70", outline="grey70")

s.update()

s.delete(hand,robe,hair,hat,towerBit)
for i in range(8):
    s.delete(orb[i])


#Animating it
x = []
y = []
time = []
xSpeed = []
ySpeed = []
line = []
x2 = []
y2 = []

for i in range(30):
    x.append(randint(225,340))
    y.append(randint(30,125))
    time.append(randint(0,130))
    xSpeed.append((788 - x[i]) / 10 )
    ySpeed.append((563 - y[i]) / 10 )
    line.append(0)

for f in range(150):
    for i in range(30):
        if f >= time[i]:
            x2 = x[i] + xSpeed[i]
            y2 = y[i] + ySpeed[i]
            
            if x2 < 788:
                line[i] = s.create_line(x[i],y[i], x2,y2, fill="white", width = 2)

            else:
                line[i] = 0

            x[i] = x[i] + xSpeed[i]
            y[i] = y[i] + ySpeed[i]

        else:
            line[i] = 0
            
    #remaking things
    for i in range(8):
            orb[i] = s.create_oval(xc-radius[i],yc-radius[i], xc+radius[i],yc+radius[i], fill = "#%02x%02x%02x" % (30+25*i, 0, 30), outline = "#%02x%02x%02x" % (30+25*i, 0, 30))

    hand = s.create_oval(372,205, 357,220, fill="bisque", outline="bisque")
    robe = s.create_polygon(235,200, 300,240, 365,200, 365,250, 317,255, 319,300, 281,300, 283,255, 235,250, fill = "blue")
    hair = s.create_polygon(288,222, 312,222, 314,235, 313,245, 310,250, 305,242, 300,253, 295,240, 290,245, 286,235,   fill="grey65")
    hat = s.create_polygon(300,200, 310,220, 315,225, 285,225, 290,220, fill="blue")   
    towerBit = s.create_rectangle(290,290, 310,300, fill="grey70", outline="grey70")
    
    s.update()
    sleep(0.03)
    
    s.delete(hand,robe,hair,hat,towerBit)
    
    for i in range(8):
        s.delete(orb[i])

    for i in range(30):
        s.delete(line[i])

s.delete(laser)
for i in range(10):
    s.delete(house[i],roof[i])
    
s.create_polygon(650,550, 700,575, 660,610, 720,580, 730,630, 800,580, 880,600, 860,560, 850,580, 900,550, fill="grey20")






## EXPLOSION ##
xC = 788
yC = 563

angle = []
x = []
y = []
r = []
speed = []
bits = []
stop = []



for i in range(200):
    angle.append(uniform(0,pi))
    x.append(788)
    y.append(563)
    stop.append(0)

    r.append(0)
    speed.append(uniform(5,10))

    bits.append(0)

for f in range(100):
    for i in range(200):
        bits[i] = s.create_rectangle(x[i],y[i], x[i]+3,y[i]+3, fill="red", outline = "red4")     
        
        if y[i] > 550:
            chance = randint(1,6)
            if chance == 1 or stop[i] == 1:
                stop[i] = 1
            else:
                x[i] = xC + r[i] * cos(angle[i])
                y[i] = yC - r[i] * sin(angle[i]) + 0.2*f**2
                r[i] = r[i] + speed[i]
                
                
        else:
            x[i] = xC + r[i] * cos(angle[i])
            y[i] = yC - r[i] * sin(angle[i]) + 0.2*f**2
            r[i] = r[i] + speed[i]
            
    s.update()
    sleep(0.03)
    for i in range(200):
        s.delete(bits[i])

        


