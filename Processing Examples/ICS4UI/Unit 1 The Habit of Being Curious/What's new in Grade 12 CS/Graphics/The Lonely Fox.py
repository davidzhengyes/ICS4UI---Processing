from tkinter import *
from random import *
myInterface = Tk()
s = Canvas(myInterface, width=1000, height=1000, background="midnight blue")
s.pack()


s.create_rectangle(0, 700, 1000, 800, fill="black")

#moon
s.create_oval(50, 50, 150, 150, fill = "khaki")

#Fox
s.create_polygon(190, 490, 215, 500, 216, 630, 197, 630, fill = "sienna4")
s.create_polygon(190, 490, 193, 520, 226, 500, fill = "OrangeRed3")
s.create_polygon(193, 520, 215, 506, 215, 565, fill = "OrangeRed")
s.create_polygon(215, 565, 195, 577, 215, 610, fill = "saddle brown")
s.create_polygon(220, 500, 265, 660, 410, 590, fill = "chocolate2")
s.create_polygon(286, 327, 340, 361, 324, 447, 250, 384, fill = "OrangeRed")
s.create_polygon(270, 315, 265, 400, 155, 380, 150, 315, fill = "MistyRose2")
s.create_polygon(270, 315, 265, 377, 286, 327, 280, 300, fill = "OrangeRed3")
s.create_polygon(215, 333, 155, 380, 180, 320, fill = "bisque3")
s.create_polygon(195, 250, 126, 278, 122, 295, 150, 315, 190, 325, 228, 325, 270, 315,
                 293, 295, 288, 278, fill = "bisque3")
s.create_polygon(166, 272, 175, 315, 190, 325, 209, 320, fill = "MistyRose2")
s.create_polygon(250, 272, 242, 315, 228, 325, 209, 320, fill = "MistyRose2")
s.create_polygon(200, 310, 183, 300, 195, 250, 223, 250, 234, 300, 218, 310, fill = "OrangeRed")
s.create_polygon(200, 300, 218, 300, 224, 310, 209, 320, 193, 310, fill = "black")
s.create_polygon(183, 300, 171, 278, 195, 250, fill = "chocolate2")
s.create_polygon(234, 300, 248, 278, 223, 250, fill = "chocolate2")
s.create_polygon(125, 247, 126, 278, 171, 278, 150, 230, fill = "MistyRose2")
s.create_polygon(287, 247, 288, 278, 248, 278, 250, 230, fill = "MistyRose2")
s.create_polygon(171, 278, 195, 250, 171, 250, 130, 245, fill = "OrangeRed")
s.create_polygon(248, 278, 223, 250, 248, 250, 282, 245, fill = "OrangeRed")
s.create_polygon(195, 250, 209, 215, 223, 250, fill = "OrangeRed3")
s.create_polygon(195, 250, 209, 215, 170, 226, fill = "chocolate2")
s.create_polygon(223, 250, 209, 215, 247, 226, fill = "chocolate2")
s.create_polygon(209, 217, 201, 175, 217, 175, fill = "OrangeRed3")
s.create_polygon(209, 217, 201, 175, 183, 180, fill = "OrangeRed")
s.create_polygon(209, 217, 217, 175, 234, 180, fill = "OrangeRed")
s.create_polygon(204, 175, 183, 180, 155, 155, fill = "OrangeRed4")
s.create_polygon(217, 175, 234, 180, 260, 155, fill = "OrangeRed4")
s.create_polygon(160, 210, 149, 167, 96, 140, 130, 205, fill = "bisque3")
s.create_polygon(257, 210, 267, 167, 318, 140, 285, 205,  fill = "bisque3")
s.create_polygon(155, 155, 95, 128, 149, 167, 160, 210, 169, 190, fill = "saddle brown")
s.create_polygon(260, 155, 319, 128, 267, 167, 257, 210, 248, 190, fill = "saddle brown")
s.create_polygon(149, 167, 95, 128, 92, 140, 110, 215, 96, 140, fill = "OrangeRed")
s.create_polygon(267, 167, 319, 128, 327, 140, 302, 215, 318, 140, fill = "OrangeRed")
s.create_polygon(130, 205, 96, 140, 110, 215, 125, 247, 135, 226, fill = "MistyRose2")
s.create_polygon(285, 205 ,318, 140, 302, 215, 287, 247, 278, 226, fill = "MistyRose2")
s.create_polygon(195, 250, 170, 226, 209, 215, 183, 180, 155, 155, 169, 190, 160, 210,
                 130, 205, 135, 226, 125, 247, 171, 250, 195, 250, fill = "OrangeRed3")
s.create_polygon(223, 250, 247, 226, 209, 215, 234, 180, 260, 155, 248, 190, 257, 210,
                 285, 205, 278, 226, 287, 247, 247, 250, 223, 250, fill = "OrangeRed3")
s.create_polygon(209, 215, 257, 210, 247, 226, fill = "OrangeRed4")
s.create_polygon(209, 320, 192, 325, 205, 333, 215, 333, 229, 324, fill = "bisque4")
s.create_polygon(292, 507, 330, 523, 317, 549, 280, 535, fill = "bisque3")
s.create_polygon(153, 445, 185, 495, 330, 548, 325, 450, fill = "MistyRose2")
s.create_polygon(292, 507, 330, 523, 317, 549, 280, 535, fill = "bisque3")
s.create_polygon(406, 403, 340, 361, 324, 447, fill = "OrangeRed3")
s.create_polygon(406, 403, 324, 447, 337, 605, 475, 595, fill = "OrangeRed")
s.create_polygon(406, 403, 397, 435, 433, 476, fill = "chocolate2")
s.create_polygon(324, 447, 397, 435, 413, 500, fill = "chocolate2")
s.create_polygon(350, 485, 447, 509, 350, 604, 310, 552, fill = "OrangeRed3")
s.create_polygon(310, 552, 350, 604, 330, 630, fill = "OrangeRed4")
s.create_polygon(475, 595, 350, 604, 430, 645, fill = "OrangeRed4")
s.create_polygon(265, 396, 275, 500, 333, 526, 325, 447, fill = "OrangeRed3")
s.create_polygon(275, 475, 270, 495, 275, 500, fill = "OrangeRed3")
s.create_polygon(270, 495, 300, 475, 283, 535, 250, 550, fill = "OrangeRed")
s.create_polygon(283, 535, 247, 640, 230, 615, 250, 550, fill = "sienna4")
s.create_polygon(250, 550, 267, 583, 233, 606, fill = "saddle brown")
s.create_polygon(155, 380, 160, 450, 257, 495, 250, 550, 277, 475, 265, 400, fill = "bisque3")
s.create_polygon(160, 450, 155, 380, 140, 443, fill = "MistyRose2")
s.create_polygon(350, 604, 330, 630, 300, 625, 305, 670, 220, 680,
                 305, 715, 385, 690, 430, 645, fill = "OrangeRed")
s.create_polygon(300, 625, 170, 610, 220, 680, 305, 670, fill = "OrangeRed3")
s.create_polygon(220, 680, 210, 705, 305, 715, fill = "OrangeRed3")
s.create_polygon(170, 610, 150, 630, 220, 680, fill = "OrangeRed4")
s.create_polygon(150, 630, 120, 645, 160, 700, 210, 705, 220, 680, fill = "MistyRose2")
s.create_polygon(170, 610, 125, 613, 80, 595, 120, 645, 150, 630, fill = "bisque3")
s.create_polygon(300, 625, 355, 645, 423, 650, 350, 660, fill = "chocolate2")



#Tree
s.create_polygon(1000, 750, 750, 750, 720, 680, 730, 600, 740, 500, 750, 400, 760, 300, 770, 0, 1000, 0, 1000, 750, fill="black", smooth="true")
s.create_rectangle(950, 450, 1000, 750, fill="black")
s.create_rectangle(950, 0, 1000, 450, fill="black")
s.create_rectangle(770, 0, 1000, 100, fill="black")



#Leaves


for n in range(1, 100):
    x = randint( 550, 800)
    y = randint( 0, 150)

    x1 = randint(0, 40)
    y1 = randint (0, 30)
    x2 = randint(0, 20)
    y2 = randint (0, 40)
    x3 = randint(0, 30)
    y3 = randint (0, 20)
    c = choice( ["black", "gray14", "gray6",] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, fill=c, smooth="true")

for n in range(1, 50):
    x = randint( 400, 550)
    y = randint( 150, 250)
    x1 = randint(0, 40)
    y1 = randint (0, 30)
    x2 = randint(0, 20)
    y2 = randint (0, 40)
    x3 = randint(0, 30)
    y3 = randint (0, 20)
    c = choice( ["black", "gray14", "gray6",] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, fill=c, smooth="true")

for n in range(1, 5):
    x = randint( 350, 400)
    y = randint( 250, 300)
    x1 = randint(0, 40)
    y1 = randint (0, 30)
    x2 = randint(0, 20)
    y2 = randint (0, 40)
    x3 = randint(0, 30)
    y3 = randint (0, 20)
    c = choice( ["black", "gray14", "gray6",] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, fill=c, smooth="true")

for n in range(1, 5):
    x = randint( 425, 575)
    y = randint( 25, 75)
    x1 = randint(0, 40)
    y1 = randint (0, 30)
    x2 = randint(0, 20)
    y2 = randint (0, 40)
    x3 = randint(0, 30)
    y3 = randint (0, 20)
    c = choice( ["black", "gray14", "gray6",] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, fill=c, smooth="true")

for n in range(1, 5):
    x = randint( 620, 720)
    y = randint( 175, 225)
    x1 = randint(0, 40)
    y1 = randint (0, 30)
    x2 = randint(0, 20)
    y2 = randint (0, 40)
    x3 = randint(0, 30)
    y3 = randint (0, 20)
    c = choice( ["gray6", "gray14", "gray3",] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, fill=c, smooth="true")




#Mushrooms
s.create_line(775, 620, 800, 700, 813, 620, fill="gray6", width=5)
s.create_arc( 750, 600, 800, 650, start=0, extent=180, fill="salmon1")
s.create_arc( 800, 600, 830, 640, start=45, extent=160, fill="tan1")


#grass

for n in range(1, 1200):
    x = randint( 0, 1000)
    y = randint( 650, 1000)
    x1 = randint(0, 20)
    y1 = randint (0, 30)
    x2 = randint(0, 100 )
    y2 = randint (0, 40)
    c = choice( ["dark slate gray", "slate gray", "light slate gray", "gray6"] )
    s.create_polygon( x, y, x+x1, y+y1, x+x2, y+y2, fill=c,)


for n in range(1, 1000):
    x = randint( 0, 1000)
    y = randint( 650, 1000)
    deltaX = randint(-10,10)
    deltaY = randint(-10,10)

    s.create_line( x, y, x+deltaX, y+deltaY, fill="LightGoldenrod3",)


#Name
s.create_text(950, 625, text = "Lina Zhou", font = "Tims 12", fill = "white")

s.update()
