class Graph {
  /*  Shows the actual status of grass, sheep and wolves
      in the graph on the left
      + contains buttons for control of entities */
   
  float[] grassPop;
  int[] sheepPop;
  int[] wolvesPop;
  int graphSize;
  float scale;
  int maxSheep;
  int maxWolves;
  
  
  Graph(float scale_) {
    scale = scale_;
    graphSize = floor((width-150-field.fieldSize*field.scale)/scale);
    wolvesPop  = new int[graphSize];
    sheepPop = new int[graphSize];
    grassPop = new float[graphSize];
    
  }

  // Updates the populations on the graph 
  void update() {
    if(sheeps.size() > maxSheep) maxSheep = sheeps.size();
    if(wolves.size() > maxWolves) maxWolves = wolves.size();
    
    for(int i=0; i<graphSize-1; i++){ //shifts the graph to left
      wolvesPop[i] = wolvesPop[i+1];
      sheepPop[i] = sheepPop[i+1];
      grassPop[i] = grassPop[i+1];
    }
    // Loads the current
    wolvesPop[graphSize-1]  = wolves.size();
    sheepPop[graphSize-1] = sheeps.size();
    grassPop[graphSize-1] = avgOfGrass();
    
  }

  void show() {
    
    // Saves coordinates
    pushMatrix();
    
    // Shifts the coordinates
    translate(50, height-50-graphSize*scale);
    stroke(0); //color of frame
    fill(360);
    rect(0,0,graphSize*scale,graphSize*scale);
    
    fill(0);
    textAlign(LEFT, CENTER-10);
    text("Highest Sheep Count:"+maxSheep, 0, -30); // Displays the data
    text("Highest Wolf Count:"+maxWolves, 0, -10); // Displays the data
    text("Year: "+frameCount/365,150, -30);
    text("Day: "+frameCount%365, 150, -10);
    
    
    // Grass
    noFill();
    stroke(120,100,50);
    beginShape(); // Starts at the first point ...
    for(int i=0; i<graphSize; i++){
      vertex(i*scale, graphSize*scale*(1 - grassPop[i]/100));
    }
    endShape(); // And then connects with the end point
    fill(120,100,50);
    text(grassPop[graphSize-1],graphSize*scale+2,graphSize*scale*(1-grassPop[graphSize-1]/100));
    
    // Sheep
    noFill();
    stroke(250,100,100);
    beginShape();
    for(int i=0; i<graphSize; i++){
      vertex(i*scale, map(sheepPop[i], 0, maxSheep, graphSize*scale, 0));
    }
    endShape();
    fill(250,100,100);
    text(sheepPop[graphSize-1],graphSize*scale+2,map(sheepPop[graphSize-1], 0, maxSheep, graphSize*scale, 0));
    
    // Wolves
    noFill();
    stroke(350,100,100);
    beginShape();
    for(int i=0; i<graphSize; i++){
      vertex(i*scale, map(wolvesPop[i], 0, maxWolves, graphSize*scale, 0));
    }
    endShape();
    fill(350,100,100);
    text(wolvesPop[graphSize-1],graphSize*scale+2,map(wolvesPop[graphSize-1], 0, maxWolves, graphSize*scale, 0));
    
    popMatrix();
  }
  
  float avgOfGrass(){ 
    float total = 0;
    for (int i=0; i<field.fieldSize; i++) {
      for (int j=0; j<field.fieldSize; j++) {
        total += lawn[i][j].quantity;        // Adds all the quantity of grass together
      }
    }
    
    // Calculates the average
    float retVal = total/sq(field.fieldSize)/lawn[0][0].maxGrass*100;            
    if(100-retVal<0.1) return 100;
    return retVal;
  }
  
}
