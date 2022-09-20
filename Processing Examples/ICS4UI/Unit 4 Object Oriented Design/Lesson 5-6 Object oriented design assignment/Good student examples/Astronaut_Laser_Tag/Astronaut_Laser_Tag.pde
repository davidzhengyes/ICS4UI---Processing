//Welcome to "AstronautLaserTag".
//In this class project you will be able to see what astronauts do in their spare time! Laser Tag! Well, maybe that's not it but its fun to imagine.
//While we are all cooped up at home it's important to relieve stress and tension between family members, similar to what Astronauts have to do while in space!
//As such it was my intention to create a medium where family members can take their quarrels with each other onto to the laser tag arena through controlling these Astronauts!
//Create your astronaut in setup() and follow proper procedure to dock them at your spacestation. Remember, this is a two player game, and as such there must be two astronauts docked to play!
//All players have three lives.
//Current player one controls: wasd for typical movement, q fires your laser. 
//Current player two controls: ijkl for typical movement, u fires your laser.
//Remember you are in space and your movement requires the use of thrusters, as such movement requires to press a desired key repeatedly (There is still gravity, although it is weaker).
//If you put your Astronaut's emotional state as calm, they will have maximum health, but they fire their laser the slowest as they're not very stressed.
//The more panicked you set your emotions the faster you can fire! But beware, increase in stress reduces your Astronauts health! Strategise to find your perfect balance!
//States: Calm -> Worried -> Panicked -> Hysterical.
//While in the arena keep an eye for usable items. These include health packs (to a max of your starting health), extra lifes (to a max of three), 
//meteor shower, which calls as you've probably guessed, a meteor shower from above. Beware! Getting hit by a meteor takes a life, and meteors can hit anyone on the arena, including you!
//Please enjoy yourself, this game is meant to be a stress reliever, and remember, stay safe in these uncertain times.
//Alright thats enough of a tedious explaination, go check out setup() to see what you, the user, can change! 
//Have fun!


PImage laserForward;
PImage laserBackward;
PImage playerForward;
PImage playerBackward;
PImage playerForwardInjured;
PImage playerBackwardInjured;
PImage heart;
PImage health;
PImage meteor;
PImage meteorIcon;

Astronaut playerOne;
Astronaut playerTwo;
Spacestation spaceStation;

//103x80

void setup() {
  //No not this, but you're getting closer!
  fullScreen();
  loadImages();
  
  //Here! You can use any integer from 1-3 to choose a map.
  //You can also change the name to anything you want!
  spaceStation = new Spacestation(int(random(1,4)), "International Space Station");

  //Astronaut made by player one.
  playerOne = spaceStation.setupLaserTag(0, "Walker", "Calm");
  
  //Astronaut made by player two.
  playerTwo = spaceStation.setupLaserTag(1, "Schattman", "Hysterical"); 
  
  spaceStation.printManuscript();
  //This is the proper procedure for putting an astronaut in space!
  //You must have docked at least two astronauts to play a game of intergalactic laser tag. (Only two players)
  playerOne.currentPosition();
  playerOne.takeOff();
  playerOne.currentPosition();
  playerOne.docking(spaceStation);
  playerOne.currentPosition();
  
  //Now see what happens if we try to do something ... improper.
  playerOne.takeOff(); //Hint, we are already in space.
  playerOne.docking(spaceStation); //Hint, we are already docked.
  
  spaceStation.printManuscript();
  
  playerTwo.currentPosition();
  playerTwo.takeOff();
  playerTwo.currentPosition();
  //P2.docking(spaceStation);
  playerTwo.currentPosition();
  
  //Now see what happens if we try to do something ... improper.
  playerTwo.takeOff(); //Hint, we are already in space.
  playerTwo.docking(spaceStation); //Hint, we are already docked.
  
  spaceStation.printManuscript();
  
  //Sets direction keys, you can change controls to your liking, but remember to but in a char for your desired key and NOT a string ('d' is a char "d" is a string).
  playerOne.setKey('w', "up");
  playerOne.setKey('a', "left");
  playerOne.setKey('d', "right");
  playerOne.setKey('s', "down");
  playerOne.setKey('q', "fire");
  
  playerTwo.setKey('i', "up");
  playerTwo.setKey('j', "left");
  playerTwo.setKey('l', "right");
  playerTwo.setKey('k', "down");
  playerTwo.setKey('u', "fire");
  
  playerOne.enemy = playerTwo;
  playerTwo.enemy = playerOne;  
}


void draw() {
  background(0);
  spaceStation.drawMap();
  spaceStation.playLaserTag();
}

void keyPressed() { 
 playerOne.onKeyPressed(key);
 playerTwo.onKeyPressed(key);
 if (key == 'r' && spaceStation.gameIsOn == false) {
   spaceStation.printResults( spaceStation.inhabitants.get(0), spaceStation.inhabitants.get(1));
   setup();
  }
}

void drawUI() {
 if (spaceStation.gameIsOn) {
   fill(111,111,111);
    rect(25,0, 100,20);
    
    if (playerOne.health >= 80)
      fill(0,255,0);
    else if (playerOne.health < 80 && playerOne.health >= 60)
      fill(255,255,0);
    else if (playerOne.health < 60 && playerOne.health > 30)
      fill(255,150,0);
    else
      fill(255,0,0);
    
    rect(25,0, playerOne.health, 20);
    
    for (int i = 0; i < playerOne.lives; i ++) {
      image(heart, 38*i + 25, 24);
    }
   
    
    fill(111,111,111);
    rect(width-125,0, 100,20);
    
    if (playerTwo.health >= 80)
      fill(0,255,0);
    else if (playerTwo.health < 80 && playerTwo.health >= 60)
      fill(255,255,0);
    else if (playerTwo.health < 60 && playerTwo.health > 30)
      fill(255,150,0);
    else
      fill(255,0,0);
    
   rect(width-125, 0, playerTwo.health, 20);
   
   for (int i = 0; i < playerTwo.lives; i ++) {
      image(heart, 38*i + width-125, 24);
    }
 }
}

void loadImages() {
  laserForward = loadImage("laser.png");
  laserBackward = loadImage("laser.png");
  playerForward = loadImage("astronautForward.png");
  playerBackward = loadImage("astronautBackward.png");
  heart = loadImage("heart.png");
  health = loadImage("healthPack.png");
  meteor = loadImage("meteor.png");
  meteorIcon = loadImage("meteorIcon.png");
  playerForwardInjured = loadImage("astronautForwardInjured.png");
  playerBackwardInjured = loadImage("astronautBackwardInjured.png"); 
}
