
// The purpose of these 2 lines is to...                 
PVector[] locations;
PVector[] speeds;

int n = 5000;   // n is the...                           
float s = 0.75; // s is the...                           


// The purpose of this procedure is to...                
void setup(){
  size(1000, 1000);
  fill(255);
  stroke(255);

  // The purpose of these 2 lines is to...
  locations = new PVector[n];
  speeds = new PVector[n];
  
  for(int i=0; i<n; i++){
    float x = random(0, width);
    float y = random(0, height);
    locations[i] = new PVector(x, y);   // ?
    speeds[i] = new PVector(0, 0);      // ?
  } 
}


// The purpose of this procedure is to...
void draw(){
    background(0);
    
    // The purpose of this loop is to...
    for(int i=0; i<n; i++){
      
      // ?
      point( locations[i].x, locations[i].y ); 
      
      // ? 
      locations[i].x += speeds[i].x;
      locations[i].y += speeds[i].y;
      
      // What does these if-statements accomplish?
      if( mouseX > locations[i].x ) 
        speeds[i].x = s;
      
      else
        speeds[i].x = -s;

      if( mouseY > locations[i].y ) 
        speeds[i].y = s;
        
      else
        speeds[i].y = -s;
    }
}


// ?
void mouseClicked() {
  for(int i=0; i<n; i++){
    locations[i].x = random(0, width);
    locations[i].y = random(0, height);
  } 
}
