def getTheThirdLetter(place1, place2):
    
    L = [place1,place2]
    
    if L.count("A")==0:
        return "A"
    
    elif L.count("B")==0:
        return "B"
    
    else:
        return "C"



def printSingleMove(d, currentPeg, targetPeg):
    print ("Move disk " + str(d) + " from " + currentPeg + " to " + targetPeg)
    


def solveTower(d, currentPeg, targetPeg):
    
    freePeg = getTheThirdLetter(currentPeg, targetPeg)

    if d == 1:
        print ("Move disk 1 from " + currentPeg + " to " + targetPeg)

    else:
        #Move all the smaller disks to the free spot
        solveTower(d-1, currentPeg, freePeg)

        #Move the biggest disk to the target spot
        print ("Move disk " + str(d) + " from " + currentPeg + " to " + targetPeg)

        #Move the smaller disks back on top of the biggest disk
        solveTower(d-1, freePeg, targetPeg)


def playGame():
    d = int(input("How many disks are in your tower? "))
    place1 = "A"
    place2 = "C"


    print( "")
    print ("Here's how to solve it!")
    print ("-----------------------")

    solveTower(d, place1, place2)

    print ("-------------------")
    


playGame()
