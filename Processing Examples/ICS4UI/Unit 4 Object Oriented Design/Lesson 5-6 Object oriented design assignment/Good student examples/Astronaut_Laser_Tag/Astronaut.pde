class Astronaut {
  String name;
  String emotionalState;
  String position = "Earth";
  int fireBuffer;
  float xPos;
  float yPos;
  int jumpCounter = 0;
  int lives = 3;
  float xSpeed = 0;
  float ySpeed = 0;
  float gravity = 0.58;
  float health;
  float maxHealth;
  float lastX;
  float lastY;
  int frameCounter = 0;
  int frameCounterImage = 0;
  int frameCounterLaser = 0;
  Astronaut enemy;
  ArrayList<Laser> myLaser = new ArrayList<Laser>();
  PImage image;
  Spacestation myMap;
  
  char up;
  char left; 
  char down;
  char right;
  char fire;
  
  boolean canFire;
  int lasersFired = 1;
  int lasersHit = 1;
  
  //Constructor method.
  Astronaut(float x, float y, Spacestation m, String n, String e) {
    this.xPos = x;
    this.yPos = y;
    this.myMap = m;
    this.name = n;
    this.emotionalState = e;
    
    if (this.emotionalState == "Calm") {
      this.health = 100;
      this.maxHealth = 100;
      this.fireBuffer = 22;
    }
    
    else if (this.emotionalState == "Worried") {
      this.health = 80;
      this.maxHealth = 80;
      this.fireBuffer = 12;
    }
    
    else if (this.emotionalState == "Panicked") {
      this.health = 60;
      this.maxHealth = 60;
      this.fireBuffer = 4;
    }
    
    else if (this.emotionalState == "Hysterical") {
      this.health = 20;
      this.maxHealth = 20;
      this.fireBuffer = 0;
    }
    
    else {
      this.health = 20;
      this.maxHealth = 20;
      this.fireBuffer = 30;
    }
  }
  
  //Makes a new laser when the fire button is pressed and conditions are true.
  void shootLaser() {
    
    Laser newLaser = new Laser(this.xPos, this.yPos+33, this.enemy, this.myMap);
    if (this.xPos - this.lastX > 0) {
      newLaser.speed = 18;
      newLaser.image = laserForward;
    }
    else {
      newLaser.speed = -18;
      newLaser.image = laserBackward;
    }
    myLaser.add(newLaser);
  }
    
    //Draws and does everything pertaining to the astronaut.
    void drawObjects() {
      if (this.lives > 0) {
        hitDetectionAndPhysics();
        checkBoundarys();
        checkItems();
        checkMeteors();       
        this.canFire = canFire();
      }
      
      

      checkGame();
      if (this.myMap.gameIsOn == false && this.lives > 0) {
        this.myMap.winner = this.name;
        this.canFire = canFire();
      }
      
    }
    
    //Creates laser and changes image based on movement. Also updates player speeds. Player flashes red when hit.
    void hitDetectionAndPhysics() {
      for (int i = 0; i < myLaser.size(); i ++) {
        myLaser.get(i).drawLaser();
        myLaser.get(i).update();
        boolean hasHitOpponent = myLaser.get(i).checkForHit();
        boolean hasHitObstacle = myLaser.get(i).checkForObstacles();
        if (hasHitOpponent) {
          this.lasersHit ++;
          enemy.health -= 20;
          if (enemy.image == playerForward) {
            enemy.image = playerForwardInjured;
            enemy.frameCounterImage = 1;
          }
          if (enemy.image == playerBackward) {
            enemy.image = playerBackwardInjured;
            enemy.frameCounterImage = 1;
          }
          if (enemy.health <= 0) {
            enemy.xPos = width/2 - 40;
            enemy.yPos = -100;
            enemy.lives --;
            enemy.health = enemy.maxHealth;
          }
          myLaser.remove(i);
        }
        else {
          myLaser.get(i).xD = this.enemy.xPos;
          myLaser.get(i).yD = this.enemy.yPos;
          if( myLaser.get(i).xPos > width || myLaser.get(i).xPos < 0 || hasHitObstacle) {
            myLaser.remove(i);
          }
        }
      }
      if (xPos - lastX  > 0 && this.frameCounterImage == 0)
        this.image = playerForward;
      else if (xPos - lastX  < 0  && this.frameCounterImage == 0)
        this.image = playerBackward;
      else if (this.frameCounterImage == 0)
        this.image = playerForward;
      
      if (this.frameCounterImage != 0) {
        this.frameCounterImage ++;
      }
      if (this.frameCounterImage == 5) {
        this.frameCounterImage = 0;
      }
      
      image(this.image, this.xPos, this.yPos);
      this.xPos += this.xSpeed;
      this.xSpeed = this.xSpeed*0.9;
      this.yPos += this.ySpeed;
  
      this.ySpeed += gravity;
      if (this.yPos > height) {
        this.yPos = - 100;
        this.lives --;
        this.health = this.maxHealth;
      }
      if (this.yPos == this.lastY) {
        this.jumpCounter = 0;
      }
    }
    
    //Checks if you hit a platform, fall off the screen, or land on a platform.
    void checkBoundarys() {
      for (int i = 0; i < this.myMap.entireMap.size(); i ++) {
        if (this.xPos + 80 > this.myMap.entireMap.get(i).xPos && this.xPos < this.myMap.entireMap.get(i).xPos + this.myMap.entireMap.get(i).l) {
          if (this.yPos < this.myMap.entireMap.get(i).yPos+this.myMap.entireMap.get(i).h && this.yPos > this.myMap.entireMap.get(i).yPos) {
            this.ySpeed = this.ySpeed*-0.3 +  this.myMap.entireMap.get(i).yS;
            this.yPos = this.myMap.entireMap.get(i).yPos+this.myMap.entireMap.get(i).h;
          }
          
          if (this.yPos + 101 > this.myMap.entireMap.get(i).yPos && this.yPos + 101 < this.myMap.entireMap.get(i).yPos+this.myMap.entireMap.get(i).h) {
            this.ySpeed = 0;
            this.yPos = this.myMap.entireMap.get(i).yPos-103;
            this.gravity = 0;
          }
          
        }
        else {
          this.gravity = 0.58;
        }
      }
      
      if (this.xPos + 80 > width) {
        this.xPos = width - 103;
      }
      
      if (this.xPos < 0) {
        this.xPos = 0;
      }
      
    }
    
    //Checks if you got hit by a meteor.
    void checkMeteors() {
      if (this.myMap.meteorShower == true) {
        for (int i = 0; i < this.myMap.theMeteors.size(); i ++) {
          if (this.xPos + 70 > this.myMap.theMeteors.get(i).xPos  && this.xPos < this.myMap.theMeteors.get(i).xPos + 70 && this.yPos > this.myMap.theMeteors.get(i).yPos && this.yPos < this.myMap.theMeteors.get(i).yPos + 150) {
            this.lives --;
            this.health = this.maxHealth;
            this.yPos = - 400;
          }
        }
      }
    }
    
    //Checks if you are on, and can use an item.
    void checkItems() {
      for (int i = 0; i < this.myMap.allItems.size(); i ++) {
        if (this.xPos > this.myMap.allItems.get(i).xPos - 50 && this.xPos < this.myMap.allItems.get(i).xPos + 50) {
          if (this.yPos > this.myMap.allItems.get(i).yPos - 100 && this.yPos < this.myMap.allItems.get(i).yPos + 30) {
            if (this.myMap.allItems.get(i).hasBeenUsed == false) {
              if (this.myMap.allItems.get(i).itemChoice == 1 && this.health != this.maxHealth) {
                this.health += 20;
                this.myMap.allItems.get(i).hasBeenUsed = true;
                this.myMap.allItems.get(i).itemChoice = round(random(1,3.49));
              }
              else if (this.myMap.allItems.get(i).itemChoice == 2 && this.lives != 3){
                this.lives ++;
                this.myMap.allItems.get(i).hasBeenUsed = true;
                this.myMap.allItems.get(i).itemChoice = round(random(1,3.49));
              }
              
              else if (this.myMap.allItems.get(i).itemChoice == 3) {
                this.myMap.meteorShower = true;
                this.myMap.allItems.get(i).hasBeenUsed = true;
                this.myMap.allItems.get(i).itemChoice = round(random(1,3.49));
              }
            }
          }
        }
      }
      
      
    }
   
   //Checks if the game is still running.
   void checkGame() {       
     if (this.lives <= 0) {
       this.myMap.gameIsOn = false;
      
     }
   }
   
   //Sets controls.
   void setKey(char a, String dir) {
     if (dir == "up") {
       this.up = a;
     }
     
     else if (dir == "left") {
       this.left = a;
     }
     
     else if (dir == "right") {
       this.right = a;
     }
     
     else if (dir == "down") {
       this.down = a;
     }
     
     else {
       this.fire = a;
     }
   }
   
   //Controls the controls and movement of your astronaut.
   void onKeyPressed(char a) {
    if (a == this.left) {
     this.lastX = this.xPos;
     this.xSpeed = -11;
     }
    if (a == this.right) {
      this.lastX = this.xPos;
      this.xSpeed = 11;
    }
    if (a == this.up && this.jumpCounter < 2) {
      this.lastY = this.yPos;
      this.ySpeed = -13;
      this.jumpCounter ++; 
    }
    if (a == this.down) {
      this.lastY = this.yPos;
      this.ySpeed += 8;
     }
    if (a == this.fire && this.canFire) {
      this.shootLaser();
      this.frameCounterLaser = 0;
      this.lasersFired ++;
    }
         
   }
   
   boolean canFire() {
     if (this.fireBuffer != this.frameCounterLaser) {
       this.frameCounterLaser ++;
       return false;
     }
     else {
       return true;         
     }
   }
   
   //Other fun functions that print to the console!
   
   //Just states the current position of your astronaut.
   void currentPosition() {
     println("FINDING CURRENT LOCATION OF: Captain " + this.name + " ..."  );
     if (this.position == "Earth") {
       int decider = int(random(0,3));
       println("Astronaut: Captain " + this.name);
       if (decider == 0) {
         println("Location: Kennedy Space Center, Florida.");
         println("Currently: Undergoing intensive g-force training.");
         println("Next mission: is currently being planned.");
       }
       else if (decider == 1) {
         println("Location: Houston, Texas.");
         println("Currently: Undergoing mandatory 2-week preflight quarantine.");
         println("Next mission: 2 weeks away.");
       }
       
       else {
         println("Location: Waterloo, Ontario.");
         println("Currently: Giving astronaut training to interested SJAM students.");
         println("Next mission: Unknown.");
       }
     }
     
     if (this.position == "Orbit") {
       println("Astronaut: Captain " + this.name);
       println("Geosynchronous orbit, " + round(random(1900,2300))  + "km above the surface of the earth.");
       println("Awaiting docking with nearest space station");
     }
     
     if (this.position == "Space Station") {
       String[] actions = {"Sleeping", "Running on the treadmill", "Performing routine hardware checks", "On a spacewalk", "Playing laser tag?"};
        println("Astronaut: Captain " + this.name);
        int decider = int(random(0,actions.length));
        println("Currently: " + actions[decider]);
        if (this.health > 50)
        println("Health: Good." );
        else 
        println("Health: Bad.");
        println("Emotional State: " + this.emotionalState );
     }
   }
   
   //Takeoff procedure, puts astronaut in space.
   void takeOff() {
     println("TAKE OFF PROCEDURE ...");
     if (this.position == "Earth") {
       String[] checks = {"Orbiter Test Conductor", "Tank and Booster Conductor", "Payload Test Conductor", "Launch Processing System", "Flight Director", "Merritt Island Launch Area", "Support Test Manager", "Safety Console Coordinator", "Chief Shuttle Project Engineer", "Landing and Recovery Director", "Superintendent of Range Operations", "Commander" };      
       int failure = int(random(0, checks.length));
       int oxygenLevel = 100;
       println("<Commence oxygen purge>");
       for (int i = 0; i < 8; i ++) {
         println("Cabin Oxygen Level: " + (oxygenLevel) + "%");
         oxygenLevel = oxygenLevel-round(random(5,10));
       }
       println("Oxygen has been succesfully purged.");
       println("<Commence systems check>");
       for (int i = 0; i < checks.length; i ++) {
         if (i == failure) {
           restartProcess(checks[i]);
         }
         else {
           println(checks[i] + "\n" + "GREEN LIGHT");
         }
       }
       println("Commence launch readiness check");
       println("Captain " + this.name + " GREEN LIGHT");
       println("Houston we are ready for launch");
       for (int i = 4; i > 1; i --) {
        println("Take off in, " + i) ;
       }
       println("We have ignition!");
       println("We have lift off!");
       println("---------------------");
       println("CHECK ...");
       println("Captain " + this.name + " ... we are now in orbit.");
       this.position = "Orbit";
     }
     else {
       println("Error, cannot take off from: " + this.position);
     }
   }
   
   
   void restartProcess(String s) {
     println(s + "\n" + "RED LIGHT");
     println("Restarting system " + s);
     println("...");
     println("System " + s + " ready for checl");
     println("Commencing check ...");
      println(s + "\n" + "GREEN LIGHT");
   }
   
   //Docks the astronaut to the Spacestation.
   void docking(Spacestation s) {
     println("DOCKING PROCEDURE ...");
     if (this.position == "Orbit") {
       println("<Commencing docking>");
       println("Target is 2km out, approaching at a rate of 50 m/s");
       println("Target is 700m out, slowing down.");
       int speed = 50;
       for (int i = 0; i < 5; i ++) {
         println("Speed: " + speed + "m/s  ...");
         speed = round(speed - random(4,8));
       }
       
       println("Target speed has been reached, " + s.name + " is 50m out");
       println("Matching rotational frequency of " + s.name);
       println("Approaching...");
       println("We are ... lined up!");
       println("Lock!");
       println("Captain " + this.name + " has successfully docked at " + s.name);
       this.position = "Space Station";
       s.inhabitants.add(this);
     }
     
     else if (this.position == "Space Station") {
       println("Captain " + this.name + " has already docked at: " + s.name);
     }
     
     else {
       println("Captain " + this.name + " is on Earth? Docking is impossible with the " + s.name);
     }
     
   }
   
   
    
  }
  
  
  
