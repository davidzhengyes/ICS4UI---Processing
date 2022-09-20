class Spacestation {
 ArrayList<Platform> entireMap = new ArrayList<Platform>();
 ArrayList<Spawn> spawnPoints = new ArrayList<Spawn>();
 ArrayList<Item> allItems = new ArrayList<Item>();
 ArrayList<Star> theStars = new ArrayList<Star>();
 ArrayList<Meteor> theMeteors = new ArrayList<Meteor>();
 ArrayList<Astronaut> inhabitants = new  ArrayList<Astronaut>();
 String[] statistics;
 String[] list = new String[5];
 String name;
 Boolean gameIsOn = true;
 Boolean meteorShower = false;
 int frameCounter = 0;
 String winner;
  
 //Constructor method.
 Spacestation(int mapChoice, String s) {
   this.name = s;
   
   if (mapChoice == 1) {
     mapOne();
   }
   
   else if (mapChoice == 2) {
     mapTwo(); 
   }
   
   else {
     mapThree();
   }
   
   for (int i = 0; i < 1000; i ++) {
     Star newStar = new Star(random(0,width), random(0, height));
     theStars.add(newStar);
   }
   
 }
  //First map.
  void mapOne() {
    Platform platformOne = new Platform(0,height-30, width/3, 30,0,0,0,0);
    Platform platformTwo = new Platform(width-width/3,height-30, width/3, 30,0,0,0,0);
    Platform platformRaiserOne = new Platform(width/3 + 100,height*3/4 - 30, width/3 - 200, 30,0,2,0,height/4);
    Platform platformThree  = new Platform(width/9, height*3/5-30, width/4, 30,0,0,0,0);
    Platform platformFive = new Platform(width*4/6,height*3/5-30, width/4, 30,0,0,0,0 );
    Platform platformSix = new Platform(width/4, height/4-30, width/2, 30, 0 ,0 ,0 ,0);
    
    Spawn spawnPointOne = new Spawn(platformOne.xPos, platformOne.yPos - 103);
    Spawn spawnPointTwo = new Spawn(platformFive.xPos, platformFive.yPos - 103);
    
    Item itemOne = new Item(platformTwo.xPos + platformTwo.l/2, platformTwo.yPos - 50);
    Item itemTwo = new Item(platformSix.xPos + platformSix.l/2, platformSix.yPos - 50);
    
    
    this.entireMap.add(platformOne);
    this.entireMap.add(platformTwo);
    this.entireMap.add(platformRaiserOne);
    this.entireMap.add(platformThree);
    this.entireMap.add(platformFive);
    this.entireMap.add(platformSix);
    
    this.spawnPoints.add(spawnPointOne);
    this.spawnPoints.add(spawnPointTwo);
    
    this.allItems.add(itemOne);
    this.allItems.add(itemTwo);
  }
  
  //Second map.
  void mapTwo() {
    Platform platformOne = new Platform(width/15, height - 30 - height/2, width/4, 30, 0, 2, 0, height/3);
    Platform platformTwo = new Platform(width - width/15 - width/4, height - 30 - height/3, width/4, 30, 0, 2, 0, height/3);
    Platform platformThree = new Platform(width*2/5, height - 60, width/5, 30,0,0,0,0);
    Platform platformFour = new Platform(width*2/5, 150, width/5, 30,0,0,0,0);
    Platform platformFive = new Platform(width*5/12, height/2-15, width/6, 30, 0,0,0,0);
    
    Spawn spawnPointOne = new Spawn(platformThree.xPos + platformThree.l/2, platformThree.yPos-103);
    Spawn spawnPointTwo = new Spawn(platformFour.xPos + platformFour.l/2, platformFour.yPos-103);
    
    Item itemOne = new Item(platformFive.xPos + platformFive.l/2, platformFive.yPos - 50);
    
    this.entireMap.add(platformOne);
    this.entireMap.add(platformTwo);
    this.entireMap.add(platformThree);
    this.entireMap.add(platformFour);
    this.entireMap.add(platformFive);
    
    this.spawnPoints.add(spawnPointOne);
    this.spawnPoints.add(spawnPointTwo);
    
    this.allItems.add(itemOne);   
  }
  
  //Third map.
  void mapThree() {
    Platform platformOne = new Platform(width/12, height/2, width/12, 30, 0, 3.2, 0, height/3);
    Platform platformTwo = new Platform(platformOne.xPos + platformOne.l + width/12, height/2, width/12, 30, 0, 2, 0, height/3);
    Platform platformThree = new Platform(platformOne.xPos + platformTwo.l, height/2, width/12, 30, 0, 2.2, 0, height/3, 1);
    Platform platformFour = new Platform(width*2/5, height - 60, width/5, 30,0,0,0,0);
    Platform platformFive = new Platform(width*2/5, 150, width/5, 30,0,0,0,0);
    Platform platformSix = new Platform(width*99/200, height/2 - height/16, width/100, height/4, 0,1,0,height/5);
    Platform platformSeven = new Platform(width - width/12 - width/4, height/3, width/4, 30, 0, 2, 0, height/4);
    Platform platformEight = new Platform(width - width/12 - width/4, height-height/3, width/4, 30, 0, 2, 0, height/4);
    
    
    Spawn spawnPointTwo = new Spawn(platformFour.xPos + platformFour.l/7, platformFour.yPos-103);
    Spawn spawnPointOne = new Spawn(platformFive.xPos + platformFive.l/2, platformFive.yPos-103);
    
    
    Item itemOne = new Item(width - width/12 - width/8, height/2);
    
    this.entireMap.add(platformOne);
    this.entireMap.add(platformTwo);
    this.entireMap.add(platformThree);
    this.entireMap.add(platformFour);
    this.entireMap.add(platformFive);
    this.entireMap.add(platformSix);
    this.entireMap.add(platformSeven);
    this.entireMap.add(platformEight);
    
    this.spawnPoints.add(spawnPointOne);
    this.spawnPoints.add(spawnPointTwo);
    
    this.allItems.add(itemOne);   
    
    
  }
  
  //Draws map.
  void drawMap() {
  
     for (int i = 0; i < this.theStars.size(); i ++) {
       this.theStars.get(i).drawStar();
     } 
      
     for (int i = 0; i < this.entireMap.size(); i ++) {
       this.entireMap.get(i).drawPlatform();
       this.entireMap.get(i).update();
      }
      
      for (int i = 0; i < this.allItems.size(); i ++) {
       this.allItems.get(i).drawItem();
      }
     callMeteorShower();
   
   if (!this.gameIsOn) {
     PFont f;
     f = createFont("Arial",18);
     textFont(f);
     fill(0,255,255);
     text(this.winner + " has won! Press R to restart.", width/2 - 100, height/2);
   }
  }
  
  //Calls meteor shower.
  void callMeteorShower() {
    int count = this.theMeteors.size();
    
    if (this.frameCounter == 0 && this.meteorShower == true) {
      frameCounter ++;
      for (int i = 0; i < 12; i ++) {
        Meteor newMeteor = new Meteor(random(0,width), random(-400, -3000));
        this.theMeteors.add(newMeteor);
      }
    }   
    for (int i = 0; i < count; i ++) {
        this.theMeteors.get(i).drawMeteor();
        this.theMeteors.get(i).updateMeteor();
        if (this.theMeteors.get(i).yPos > height) {
          this.theMeteors.remove(i);
          count --;
          i --;
        }
      }
      
      if (this.theMeteors.size() == 0) {
        this.frameCounter = 0;
        this.meteorShower = false;
      }
  }
  
  Astronaut setupLaserTag(int Pnum, String n, String e) {
    Astronaut p = new Astronaut(spawnPoints.get(Pnum).xPos, spawnPoints.get(Pnum).yPos, this, n, e);
    return p;
  }
  
  //What runs everything in Draw().
  void playLaserTag() {
    if (this.inhabitants.size() < 2) {
     PFont f;
     f = createFont("Arial",18);
     textFont(f);
     fill(0,255,0);
     text("Not enough astronauts docked at the station!", width/2 - 200, height/2);
     text("Go follow proper procedure and dock a few more in setup().", width/2-200, height/2 + 30);
    }
    else {
      this.inhabitants.get(0).drawObjects();
      this.inhabitants.get(1).drawObjects();
  
      this.inhabitants.get(0).lastY = this.inhabitants.get(0).yPos;
      this.inhabitants.get(1).lastY = this.inhabitants.get(1).yPos;
  
      drawUI();
    }
  }
  
  //Prints results of game.
  void printResults(Astronaut x, Astronaut y) {
    if (this.gameIsOn == false) {
      println("---------------------------------------------------------------");
      println(x.name +" vs. " + y.name) ;
      println("Outcome: " + this.winner + " was victorious!");
      println(x.name + " accuracy: " + round((100*x.lasersHit/x.lasersFired)) + "%");
      println(y.name + " accuracy: " + round((100*y.lasersHit/y.lasersFired)) + "%");
    }
  }
  
  //Prints the manuscript of the space station.
  void printManuscript() {
    println("Manuscript: " + this.name);
    println("--------------------------");
    println("Number of Inhabitants: " + this.inhabitants.size());
    if (this.inhabitants.size() != 0) {
      println("Inhabitants: ");
      for (int i = 0; i < this.inhabitants.size(); i ++) {
        println("Astronaut: Captain " + this.inhabitants.get(i).name);
      }
    }
    else {
     println("There are currently no inhabitants onboard " + this.name);
    }
    if (this.inhabitants.size() == 0) {
      println("Life Support Systems: Off");
      println("Water Recycling: Off");
      println("Solar Generators: Off");
      println("Sewage Systems: Off");
      println("Laser Tag Systems: Off");
    }
    else if (this.inhabitants.size() == 1) {
      println("Life Support Systems: On");
      println("Water Recycling: On");
      println("Solar Generators: On");
      println("Sewage Systems: On");
      println("Laser Tag Systems: Off");
    }
    else {
      println("Life Support Systems: On");
      println("Water Recycling: On");
      println("Solar Generators: On");
      println("Sewage Systems: On");
      println("Laser Tag Systems: On");
    }
  }
  
}

//Smaller classes that are used by the Spacestation class.
class Spawn {
  float xPos;
  float yPos;
  
  Spawn(float x, float y) {
    this.xPos = x;
    this.yPos = y;
  }
}

class Star {
  float xPos;
  float yPos;
  
  Star(Float x, float y) {
    this.xPos = x;
    this.yPos = y;
  }
  
  void drawStar() {
    fill(255);
    circle(this.xPos, this.yPos, 2);
  }
  
}

class Meteor {
  float xPos;
  float yPos;
  float ySpeed = random(5,15);
  
  Meteor(Float x, float y) {
    this.xPos = x;
    this.yPos = y;
  }
  
  void drawMeteor() {
    image(meteor, this.xPos, this.yPos);
  }
  
  void updateMeteor() {
    this.yPos += this.ySpeed;
  }
  
}
