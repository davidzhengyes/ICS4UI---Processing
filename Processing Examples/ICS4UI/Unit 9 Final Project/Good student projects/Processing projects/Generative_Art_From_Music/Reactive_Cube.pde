class cubeFunction { // Creates a class for the cube. 

  float zStart = -15000; // Z Position start.
  float zFinish = 15000; // Z Position finish. 
  float X, Y, Z; // Initialize X, Y, Z variables (Position).
  float rotatX, rotatY, rotatZ; // Initialize X, Y, Z variables (Rotation).
  float changeRX, changeRY, changeRZ; // Initialize X, Y, Z variables (Change in rotation).
  
  cubeFunction() {
    X = random(0, width); // Random cube position (X, Y, Z)
    Y = random(0, height);
    Z = random(zStart, zFinish); 
    
    rotatX = random(0, 1); // Random cube rotation (X, Y, Z)
    rotatY = random(0, 1);
    rotatZ = random(0, 1);
  }
  
  void cubeDisplay(float rangeLow, float rangeMedium, float rangeHigh, float myIntensity, float globalRange){
    color displayColor = color(rangeLow * .20, rangeMedium * .20, rangeHigh * .20, myIntensity * 40); // Determines color and transparency. The audio range represents color and the intensity of the beat is the transparency. 
    fill(displayColor, 25); // Fill it with color from above. 
    
    stroke(255); // White border on cubes.
    
    pushMatrix();
    translate(X, Y, Z);
    
    changeRX = changeRX + myIntensity * (rotatX/1000); // Change in rotation dependent on beats by using intensity (X, Y, Z).
    changeRY = changeRY + myIntensity * (rotatY/1000);
    changeRZ = changeRZ + myIntensity * (rotatZ/1000);
    
    rotateX(changeRX); // Rotate by the change from above (X, Y, Z).
    rotateY(changeRX);
    rotateZ(changeRX);
    
    box(100 + (myIntensity/2)); // Create the cubes and scale them up on any beats. 
    
    popMatrix();
    
    Z = Z + (1 + (myIntensity / 5) + ((globalRange / 150) * (globalRange / 150) )); // Increase the Z position, moves faster on beats. 
    
    if ( Z >= zFinish){ // When the cube hits the maximum Z position (zFinish), the cubes will reset to the start with random X and Y.
      X = random(0, width);
      Y = random(0, height);
      Z = zStart;
    }
  }
}

void cubeDraw(){
  pRangeHighs = rangeHighs; // Previous range of frequencies.
  pRangeMedium = rangeMedium;
  pRangeLows = rangeLows;
 
  rangeHighs = 0; // Current range of frequencies. 
  rangeMedium = 0;
  rangeLows = 0;

  for(int i = 0; i < fft.specSize() * spectrumLows; i = i + 1){
    rangeLows = rangeLows + fft.getBand(i);
  }
  
  for(int i = int(fft.specSize() * spectrumLows); i < fft.specSize() * spectrumMedium; i = i + 1){
    rangeMedium = rangeMedium + fft.getBand(i);
  }
  
  for(int i = int(fft.specSize() * spectrumMedium); i < fft.specSize() * spectrumHighs; i = i + 1){
    rangeHighs = rangeHighs + fft.getBand(i);
  }
  
  if ( pRangeLows > rangeLows ) {  // If the previous range is higher than the current, decrease it by the decrease rate. 
    rangeLows = pRangeLows - rangeDecrease; 
  }  if ( pRangeMedium > rangeMedium ) {
    rangeMedium = pRangeMedium - rangeDecrease;
  }  if ( pRangeHighs > rangeHighs ) {
    rangeHighs = pRangeHighs - rangeDecrease; 
  }
  
  float globalRange = 0.66*rangeLows + 0.8*rangeMedium + rangeHighs;
  
  background(rangeLows/20,rangeMedium/20,rangeHighs/20);
  
  for(int i = 0; i < numberOfCubes; i = i + 1){
    float myIntensity = fft.getBand(i); // Intensity of the beat / band of the song.
    cubes[i].cubeDisplay(rangeLows, rangeMedium, rangeHighs, myIntensity, globalRange);
  }
}
    
    
    
    
