class Status {
  
  String message = "All is well in the world.";
  
  String[] scaleMessage = { "A village in ", "A small town in ", "A big city in ", "Half of ", "The entirety of " };
  String[] countries = loadStrings("countries.txt");
  String[] destroyMessage = { " is now gone.", " has been destroyed.", " has been wiped off the face of the Earth.", " ceases to exist.", " has been scattered into the atmosphere." };
  
  
  Status() {}
  
  
  void asteroidNews() {
  
  int scaleIndex = int( random( 0, scaleMessage.length ) );
  int countriesIndex = int( random( 0, countries.length ) );
  int destroyIndex = int( random( 0, destroyMessage.length ) );
  
  this.message = scaleMessage[scaleIndex] + countries[countriesIndex] + destroyMessage[destroyIndex];
    
  }
  
  
  void display() {
    this.displayPowerBar();
    if( statusOn ) {
      this.displayStatusMessage();
      this.displayTimeStep();
    }
  }
  
  
  void displayStatusMessage() {
    
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text( this.message, width/2, height - 26);
    
  }
  
  
  void displayPowerBar() {
    
    fill(255);
    rect(width/2 - aimPower*200, height - 3, aimPower*400, 4, 2);
    
  }
  
  
  void displayTimeStep() {
    
    fill(255);
    textAlign(RIGHT);
    textSize(14);
    text( nf(timeStep, 0, 2) + "x speed", width-8, 14 );
    
  }
  
  
}
