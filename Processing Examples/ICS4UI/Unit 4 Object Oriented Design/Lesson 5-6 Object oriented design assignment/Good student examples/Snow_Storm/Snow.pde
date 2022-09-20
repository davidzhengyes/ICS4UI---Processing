class Snow {
    ArrayList snow;
  
    //to keep track of all of the flakes
    Snow() {
        snow = new ArrayList();
    }

    //checking if the flakes have hit the ground or the top of the stack
    void ifLanded(BottomStack landed) {
        
        //for loop to check every single flake running for the len of the arraylist
        for( int i = 0 ; i < snow.size() ; i++ ) {
            SnowFlake s = (SnowFlake)snow.get(i);
            if( landed.ifLanded(s) ) {
                snow.remove(s);
                landed.add(s);
            }
        }
    }
  
  
    //creating new snow and adding it to array
    void newSnow(float spawnR) {
        if( random(spawnR) < 1.0 ) {
            snow.add(new SnowFlake());
        }
    }

    //Drawing the snow in its new position every frame
    void draw() {
        for( int i = 0 ; i < snow.size() ; i++ ) {
            SnowFlake s = (SnowFlake)snow.get(i);
            s.move();
            s.draw();
        }
    }
}
