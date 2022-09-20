class Grass {
  /*  
      area    = 10m2
      density = 2.6kg
      growth  = 0.2kg/10m2/day
   
   */
   
  float quantity; // 0 to 100
  float rateOfGrowth;
  float maxGrass;
  
  Grass() {
    quantity = numGrass*random(-0.1,0.1)+numGrass; // Initial grass
    rateOfGrowth = 0.2;        // Rate of growth per frame
    maxGrass = 5.1;
  }

  void update() { //  If there is more grass than max, it equals the max
    quantity += rateOfGrowth;
    if(quantity>maxGrass) quantity = maxGrass; 
  }

}
