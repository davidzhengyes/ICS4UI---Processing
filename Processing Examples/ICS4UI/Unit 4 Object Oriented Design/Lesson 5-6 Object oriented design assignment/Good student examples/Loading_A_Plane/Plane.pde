class Plane
{
    int totalPeople;
    int rows;
    int columns;
    int offset;
    Person[] people;
    boolean[][] seats;
    boolean[][] assignedSeats;
    int center;
    int frame;
    boolean done;
    String name;
    
    Plane(int rowi, int coli, int offseti, int centeri) {
        this.totalPeople = rowi * coli;
        this.rows = rowi;
        this.columns = coli;
        this.offset = offseti;
        this.center = centeri;
        this.people = new Person[this.totalPeople];
        this.frame = 0;
        this.done = false;
        this.name = "";
    }
    
     int[] getLocation(int r, int c) {
        int wGap = (width - this.offset) / this.rows;
        int hGap = PEOPLESIZE;
        int newX = this.offset + r * wGap;
        int newY = hGap * (c  - int((float)(this.columns / 2))) + this.center;
        if (c >= this.columns / 2) {
            newY += hGap;
            newY += PEOPLESIZE;
            
        } else {
            newY -= PEOPLESIZE;
        }
        int[] dimensions = { newX, newY };
        return dimensions;
    }
    
     void fillPlane(String method) {
        switch (method) {
            case "random": {
                this.fillRandom();
                this.name = "Random";
                break;
            }
            case "rowTB": {
                this.fillPlaneByRow();
                this.name = "Rows Top to Bottom";
                break;
            }
            case "sectionsBF": {
                this.fillSectionsBF(5);
                this.name = "Sections Back to Front";
                break;
            }
            case "sectionsFB": {
                this.fillSectionsFB(5);
                this.name = "Sections Front to Back";
                break;
            }
            case "alternating": {
                this.fillAlternating();
                this.name = "Alternating";
                break;
            }
            default:
                break;
        }
    }
    
     void insertPerson(int r, int c, int i) {
        int[] location = new int[2];
        location = this.getLocation(r, c);
        this.people[i] = new Person(i * PEOPLESIZE * -1, this.center, location[0], location[1], 5, PEOPLESIZE);
    }
    
     void fillPlaneByRow() {
        int switches = 0;
        int curr = 0;
        for (int i = 0; i < this.totalPeople; ++i) {
 
            int c =  curr;
            
            int r = this.rows  - i % this.rows - 1;
            if (i%int(totalPeople /this.columns )== 0 && i != 0) {
               if (switches % 2 == 0) {
                 curr = (columns - curr) - 1;
                 
               } else {
                 curr = (columns - curr);
               }
               switches += 1;
            }
            println(curr);
            this.insertPerson(r, c, i);
     
        }
    }
    
     void fillRandom() {
        ArrayList<Integer> unassigned = new ArrayList<Integer>();
        for (int i = 0; i < this.totalPeople; ++i) {
            unassigned.add(i);
        }
        for (int i = 0; i < this.totalPeople; ++i) {
            int randomP =  int(random((float)unassigned.size()));
            int c =  int((float)(i / this.rows));
            int r = i % this.rows;
            this.insertPerson(r, c, unassigned.get(randomP));
            unassigned.remove(randomP);
        }
    }
    
     void fillSectionsFB(int sections) {
        ArrayList<Integer> unassigned = new ArrayList<Integer>();
        for (int i = 0; i < sections; ++i) {
            for (int j = 0; j <  int((float)(this.totalPeople / sections)); ++j) {
                unassigned.add(j);
            }
            for (int j = 0; j <  int((float)(this.totalPeople / sections)); ++j) {
                int randomP =  int(random((float)unassigned.size()));
                int c =  int(float(j) /  int((float)(this.totalPeople / sections)) * this.columns);
                int r = j %  int((float)(this.rows / sections)) +  int((float)(this.rows / sections)) * i;
                
                this.insertPerson(r, c, unassigned.get(randomP) +  int((float)(this.totalPeople / sections)) * i);
                unassigned.remove(randomP);
            }
            unassigned.clear();
        }
    }
    
     void fillSectionsBF(int sections) {
        ArrayList<Integer> unassigned = new ArrayList<Integer>();
        for (int i = sections - 1; i > -1; --i) {
            for (int j = 0; j <  int((float)(this.totalPeople / sections)); ++j) {
                unassigned.add(j);
            }
            for (int j = 0; j <  int((float)(this.totalPeople / sections)); ++j) {
                int randomP = int(random((float)unassigned.size()));
                int c =  int(float(j) /  int((float)(this.totalPeople / sections)) * this.columns);
                int r = this.rows - 1 - (j %  int((float)(this.rows / sections)) +  int((float)(this.rows / sections)) * i);
                this.insertPerson(r, c, unassigned.get(randomP) +  int((float)(this.totalPeople / sections)) * i);
                unassigned.remove(randomP);
            }
            unassigned.clear();
        }
    }
    
    void fillAlternating() {
      
      int curr = 0;
      int switches = 0;
      boolean doit = false;
      
      for (int i = 0; i < totalPeople / 2; i++) {
       int r = i % (this.rows/2);
      
       
       if (doit) {
         doit = false;
         if (switches % 2 == 0) {
           curr = (columns - curr) - 1;
         } else {
           curr = (columns - curr);
         }
         switches += 1;
       }
       int c = curr;
  
       if (r == this.rows/2 - 1) {
         doit = true;
       }
       insertPerson(this.rows - 1 - r*2,c,i);
      }
      switches = 0;
      curr = 0;
      doit = false;
      for (int i = totalPeople / 2; i < totalPeople; i++) {
       int r = i % (this.rows/2);
       
       if (doit) {
         doit = false;
         if (switches % 2 == 0) {
           curr = (columns - curr) - 1;
         } else {
           curr = (columns - curr) ;
         }
         switches += 1;
       }
       int c = curr;
       
       if (r == this.rows/2 - 1) {
         doit = true;
       }

       insertPerson(this.rows -1- (r*2+1),c,i);
      }
    }
    
 
    
     void update() {
      boolean stopped = true;
      fill(255,0,0);
      textSize(20);
      textAlign(LEFT);
      text("frame: " + str(this.frame),10, this.center-10-PEOPLESIZE*(this.columns - 1));
      textAlign(CENTER);
      text( this.name,this.offset + 300, (this.center-10)-PEOPLESIZE*(this.columns - 1));
      stroke(255,0,0);
      line(0, this.center+PEOPLESIZE*(this.columns - 1) + 50, width, this.center+PEOPLESIZE*(this.columns - 1)+ 50);
        for (int i = 0; i < this.people.length; ++i) {
          this.people[i].drawSeat();
        }
        for (int i = 0; i < this.people.length; ++i) {
            this.people[i].drawSelf();
            if (this.people[i].move(this.people)) {
              stopped = false;
            }
        }

      if (!this.done){
      

        this.frame += 1;
        if (stopped) {
          this.done = true;
          println(this.name, "finished in", this.frame, "frames");
        }
      }
    }
}
