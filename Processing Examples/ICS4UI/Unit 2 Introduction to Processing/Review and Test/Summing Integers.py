#SETS UP THE DRAWING WINDOW
from tkinter import *
root = Tk()
screen = Canvas( root, width=500, height=800, background = "black" )
screen.pack()


#GLOBAL VARIABLES
numRows = 34
summations = []
deltaY = 750/numRows


#MAIN PROGRAM
def mainProgram():
    
    for i in range(1, numRows+1):
        nextRowToPrint = str(i) + " = " + getSummation(i)
        summations.append( nextRowToPrint  )

    drawSummationsOnScreen()


#DRAWS THE STRINGS IN THE ARRAY ONTO THE SCREEN AS TEXT
def drawSummationsOnScreen():
    yRow = 30
    
    for i in range(0, numRows):
        screen.create_text(50, yRow, text=summations[i], anchor = W, fill="yellow")
        yRow = yRow + deltaY


#RETURNS THE SUMMATION OF n AS A STRING OF TERMS.  EX. getSummation(10) RETURNS "1+2+3+4"
def getSummation(n):
      
    if n == 1:
        return "Can't be done"

    elif n % 2 == 1:  #IF n IS ODD AND BIGGER THAN 1, THEN JUST USE n/2 AND n/2 + 1
        halfN = int(n/2)
        return makeSumString( halfN, halfN+1 )

    else:           #IF N IS EVEN...
        x = n
        
        while x % 2 == 0 :   #DIVIDE n BY 2 REPEATEDLY UNTIL YOU REACH AN ODD NUMBER
            x = x/2

        if x > 1:  #IF THAT ODD NUMBER > 1, THEN n HAS AN ODD FACTOR, SO THE SUM CAN BE FORMED
            anchor = int(n/x)
            start = anchor - int(x/2)
            end = anchor + int(x/2)

            if start <= 0:  #FOR CASES LIKE 18 = -2 + -1 + 0 + 1 + 2 + 3 + 4 + 5 + 6, JUST REASSIGN THE VALUE OF start TO -1*start + 1
                start = -1*start + 1

            return makeSumString(start, end)


        else:   #n HAS NO ODD FACTOR (IT'S A POWER OF 2), SO THE SUM CAN'T BE FORMED
            return "Can't be done"


#GIVEN THE START AND END, FORMS THE PRINTABLE STRING OF TERMS.  EX.  makeSumString(4, 8) RETURNS "4+5+6+7+8"
def makeSumString(start, end):
    sumString = ""
    
    for x in range(start, end+1):
        if x != end:
            sumString = sumString + str(x) + " + "

        else:
            sumString = sumString + str(x)

    return sumString


#PROCEDURE CALL THAT RUNS THE PROGRAM
mainProgram()
    
