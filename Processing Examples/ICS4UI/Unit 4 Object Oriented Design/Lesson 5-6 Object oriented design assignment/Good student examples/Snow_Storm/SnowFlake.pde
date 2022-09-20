class SnowFlake {
    //How big the flakes will be
    int minR = 2;
    int maxR = 5;
  
    //how fast the wind will blow the flakes
    float maxXspeed = 2.5;
    
    //max and min speeds of flakes
    float minSpeed = snowS;
    float maxSpeed = snowS+3;
  
    int intMin =  50;
    int intMax = 200;
     
    //position, speed, size, time, spawn rate
    PVector p;
    PVector v;
    float r;
    int timeStep;
    int spawnR;
    
     
    //Snowflake "properties"
    SnowFlake() {
        timeStep = 0;
        
        //where flakes spawn in
        p = new PVector(random(width), 0);
        
        //how fast given flake moves
        v = new PVector(random(-maxXspeed, maxXspeed), random(minSpeed, maxSpeed));
        
        //How big the flake is
        r  = random(minR, maxR);
        
        //how often they spawn
        spawnR = (int)(random(intMin, intMax));
    }
    
    //moving the flakes
    void move() {
        timeStep++;
        p.add(v);
        
        //making sure the flakes stay on the screen
        while( p.x < 0 ) { 
          p.x += width; 
        }
        
        while( width < p.x ) { 
          p.x -= width; 
        }
        
        
        if( timeStep % spawnR == 0 ) {
            v.x = random(-maxXspeed, maxXspeed);
        }
    }
    // drawing the snowflakes
    void draw() {
        noStroke();
        fill(snowC);
        ellipse(p.x, p.y, r * 2, r * 2);
    }
}
