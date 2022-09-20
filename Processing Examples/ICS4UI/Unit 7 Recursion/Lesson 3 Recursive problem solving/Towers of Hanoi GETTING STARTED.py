def getTheThirdLetter(place1, place2):
    L = [place1, place2]
    
    if L.count("A") == 0:
        return "A"
    
    elif L.count("B") == 0:
        return "B"
    
    else:
        return "C"



def solveTower(d, currentPeg, targetPeg):
    freePeg = getTheThirdLetter(currentPeg, targetPeg)

    #Base case
    if d == 1:
          print("Move disk 1 from", currentPeg, "to", targetPeg)

    else:
          solveTower(d-1, currentPeg, freePeg)  #Moves the top d-1 disks from A to B
          print("Move disk", d, " from", currentPeg, "to", targetPeg)  #Moves the biggest disk to C
          solveTower(d-1, freePeg, targetPeg)   #Moves the top d-1 disks from B to C           
          
          
    
    #CODE THE REST


def playGame():
    d = int(input("How many disks are in your tower? "))

    print( "")
    print ("Here's how to solve it!")
    print ("-----------------------")

    solveTower(d, "A", "C")


playGame()
