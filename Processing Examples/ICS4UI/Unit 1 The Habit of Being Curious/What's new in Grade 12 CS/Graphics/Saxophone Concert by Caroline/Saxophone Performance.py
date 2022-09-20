from tkinter import *
from time import *
from math import *
from random import *

tk = Tk()
screen = Canvas(tk, width=1000, height=800, background="gray17")
screen.pack()

Sax = PhotoImage(file = "Sax1.gif")

#Background
#Stage**********************************************************************************************
screen.create_rectangle(100, 100, 900, 590, fill="gray14", outline="")
screen.create_rectangle(200, 500, 800, 700, fill="burlywood3", outline="")
screen.create_rectangle(100, 600, 900, 700, fill="burlywood2", outline="")
screen.create_rectangle(200, 500, 160, 600, fill="burlywood3", outline="")
screen.create_rectangle(110, 550, 150, 650, fill="burlywood3", outline="")
screen.create_rectangle(150, 500, 160, 650, fill="burlywood4", outline="")
screen.create_rectangle(100, 550, 110, 700, fill="burlywood4", outline="")
screen.create_rectangle(800, 500, 850, 600, fill="burlywood3", outline="")
screen.create_rectangle(850, 550, 900, 650, fill="burlywood3", outline="")
screen.create_rectangle(840, 500, 850, 650, fill="burlywood4", outline="")
screen.create_rectangle(890, 550, 901, 700, fill="burlywood4", outline="")

#Curtains*********************************************************************************************
screen.create_polygon(900, 200, 875, 375, 800, 500, 950, 500, fill="firebrick4", smooth=True, outline="black")
screen.create_oval(825, 75, 975, 300, fill="firebrick4")
screen.create_polygon(100, 200, 125, 375, 200, 500, 50, 500, fill="firebrick4", smooth=True, outline="black")
screen.create_oval(25, 75, 175, 300, fill="firebrick4")
screen.create_oval(100, 25, 260, 175, fill="firebrick4")
screen.create_oval(260, 25, 430, 175, fill="firebrick4")
screen.create_oval(430, 25, 590, 175, fill="firebrick4")
screen.create_oval(590, 25, 750, 175, fill="firebrick4")
screen.create_oval(750, 25, 900, 175, fill="firebrick4")
screen.create_line(885, 298, 900, 298, fill="orange1", width=5)
screen.create_line(100, 298, 115, 298, fill="orange1", width = 5)
screen.create_rectangle(25, 25, 950, 100, fill="gray17", outline="")
screen.create_rectangle(25, 100, 100, 500, fill="gray17", outline="")
screen.create_rectangle(900, 100, 975, 500, fill="gray17", outline="")

#Audience***********************************************************************************************
x1 = 175
y1 = 675
x2 = 275
y2 = 775 
screen.create_oval(x1, y1, x2, y2, fill="black")
screen.create_oval(x1+100, y1, x2+100, y2, fill="black")
screen.create_oval(x1+200, y1, x2+200, y2, fill="black")
screen.create_oval(x1+300, y1, x2+300, y2, fill="black")
screen.create_oval(x1+400, y1, x2+400, y2, fill="black")
screen.create_oval(x1+500, y1, x2+500, y2, fill="black")
screen.create_oval(x1+600, y1, x2+600, y2, fill="black")

screen.create_polygon(175, 1100, 175, 725, 225, 700, 275, 725, 275, 1100, fill="black", smooth=True)
screen.create_polygon(275, 1100, 275, 725, 325, 700, 375, 725, 375, 1100, fill="black", smooth=True)
screen.create_polygon(375, 1100, 375, 725, 425, 700, 475, 725, 475, 1100, fill="black", smooth=True)
screen.create_polygon(475, 1100, 475, 725, 525, 700, 575, 725, 575, 1100, fill="black", smooth=True)
screen.create_polygon(575, 1100, 575, 725, 625, 700, 675, 725, 675, 1100, fill="black", smooth=True)
screen.create_polygon(675, 1100, 675, 725, 725, 700, 775, 725, 775, 1100, fill="black", smooth=True)
screen.create_polygon(775, 1100, 775, 725, 825, 700, 875, 725, 875, 1100, fill="black", smooth=True)


#Notes********************************************************************************************
numNotes=0
noteBody=[]
noteLine=[]
notesx=640
notesy=375
notex=[]
notey=[]
noteyspeed=[]
colours=["firebrick1", "white", "white", "green3", "dodgerblue3", "purple1"]
speeds = [-3, 3] #-3 is for notes in the lower stream, 3 is for notes in the upper stream

for i in range(300):
    Saxcreate = screen.create_image(700, 450, image=Sax)
    noteBody.append(i)
    notex.append(notesx)
    notey.append(notesy)
    noteLine.append(i)
    noteyspeed.append( speeds[i%2] )  #fills noteyspeed with [-3, 3, -3, 3, -3, 3,...] which will create the
                                       #upper and lower streams of notes

f = 0

while notex[299] > 0: #Animates for as long as the last note is still on screen...
    
    if f < 300:  #If we haven't yet played 300 notes, then generate a new note
        numNotes = numNotes + 1
        
    for i in range(0, numNotes): #Draws all the notes that have been played
        noteBody[i] = screen.create_oval(notex[i], notey[i], notex[i] + 15, notey[i] + 10, fill=colours[i%len(colours)])
        noteLine[i] = screen.create_line(notex[i] + 15, notey[i] +5, notex[i] + 15, notey[i] - 20, fill=colours[i%len(colours)], width = 2)

        notex[i] = notex[i] - 5 #Causes the notes to go to the left
        notey[i] = notey[i] - noteyspeed[i] - 4*sin(0.12*(f-10*i)) #Makes the notes go up, but with a sinusoidal variation
        
    screen.update()
    sleep(0.03)

    for i in range(0, numNotes):
        screen.delete(noteBody[i], noteLine[i])

    f = f + 1

###Petals**********************************************************************************************
numPetals = 125
petalDrawings = []
px1=[]
py1=[]
px2=[]
py2=[]
ySpeeds = []
colourChoices = ["red", "deeppink3", "hotpink", "mediumvioletred"]
colours = []


for i in range(numPetals):
    petalDrawings.append(0)
    px1.append (uniform(200,800))
    px2.append (px1[i] + 10)
    py1.append (randint(575,700))
    py2.append (py1[i] +10)
    ySpeeds.append( uniform(-32,-15) )
    colours.append( choice(colourChoices) )


while abs(min(ySpeeds)) > 0: #Keep animating for as long as any petal still has positive speed
    for i in range (numPetals):
        py1[i] = py1[i] + ySpeeds[i]
        py2[i] = py1[i] + 5
        petalDrawings[i] = screen.create_oval(px1[i], py1[i], px2[i], py2[i], fill=colours[i], outline=colours[i])
        
    screen.update()
    sleep(0.03)

    for i in range(numPetals):
        if py2[i] >= 550 and ySpeeds[i] >= 0:   #If a petal is falling (not rising) and has reached height 550, 
            ySpeeds[i] = 0                      #then make it stop, but don't delete it so that it stays on screen

        else:
            screen.delete(petalDrawings[i]) #But if it's rising or hasn't yet fallen to height 550, 
            ySpeeds[i] = ySpeeds[i] + 1.2   #then increase its speed with gravity and delete it before the next frame
