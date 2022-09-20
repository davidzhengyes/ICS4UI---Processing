
#EXAMPLE:  makeSumString(4, 8) returns the string "4+5+6+7+8"
def makeSumString(start, end):
    sumString = ""
    
    for x in range(start, end+1):
        if x != end:
            sumString = sumString + str(x) + " + "

        else:
            sumString = sumString + str(x)

    return sumString


#CALLS makeSumString() ON THE CORRECT VALUES OF START AND END
def getSummation(n):
      
    if n % 2 == 1:  #IF N IS ODD, JUST USE N/2 AND N/2 + 1
        halfN = int(n/2)
        return makeSumString( halfN, halfN+1 )

    else:           #IF N IS EVEN...
        x = n
        
        while x % 2 == 0 :  #DIVIDE N BY 2 REPEATEDLY UNTIL YOU REACH AN ODD NUMBER
            x = x/2

        if x > 1:  #IF THAT ODD NUMBER > 1, THEN N HAS AN ODD FACTOR, SO THE SUM CAN BE FORMED
            powerOf2 = int(n/x)
            start = powerOf2 - int(x/2)
            end = powerOf2 + int(x/2)

            if start <= 0:  #FOR CASES LIKE 18 = -2 + -1 + 0 + 1 + 2 + 3 + 4 + 5 + 6. JUST REASSIGN THE VALUE OF START TO -1*START + 1
                start = -1*start + 1

            return makeSumString(start, end)


        else:   #N HAS NO ODD FACTOR, SO THE SUM CAN'T BE FORMED
            return "Can't be done"


#RUNS THE TEST CASES
for n in range(1, 65):
    print( int(n), "=",  getSummation(n) )
    
