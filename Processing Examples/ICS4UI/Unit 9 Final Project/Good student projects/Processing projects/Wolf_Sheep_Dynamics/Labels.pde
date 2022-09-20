class Labels {

  Label labs[][];
  Label showV[];
  float rG, cG, w1, w2, h1;

  Labels() {
    labs = new Label[2][];
    labs[0] = new Label[8];
    labs[1] = new Label[8];
    showV = new Label[3]; 

    rG = 10;        // Row gaps
    cG = 5;         // Column gap
    w2 = width - field.fieldSize*field.scale - 150;
    w1 = (w2-cG)/2;
    h1 = 25;
    
    
    // 'Add' and 'remove' button colours
    color green = color(128, 100, 60, 75);
    color red = color(0, 100, 60, 75);
  
  
    // Labels for GUI buttons\
    
    // Sheep Buttons
    labs[0][0] = new Label(50, 50, w1, h1, "add 10 sheep", green);
    labs[0][1] = new Label(50, 50+1*(h1+rG), w1, h1, "add 100 sheep", green);
    labs[0][2] = new Label(50, 50+2*(h1+rG), w1, h1, "add 500 sheep", green);
    labs[0][3] = new Label(50, 50+3*(h1+rG), w1, h1, "add 5000 sheep", green);
    labs[0][4] = new Label(50, 50+4*(h1+rG), w1, h1, "remove 10 sheep", red);
    labs[0][5] = new Label(50, 50+5*(h1+rG), w1, h1, "remove 100 sheep", red);
    labs[0][6] = new Label(50, 50+6*(h1+rG), w1, h1, "remove 1000 sheep", red);
    labs[0][7] = new Label(50, 50+7*(h1+rG), w1, h1, "remove all sheep", red);
  
  
    // Wolf buttons
    labs[1][0] = new Label(50+w1+cG, 50, w1, h1, "add 1 wolf", green);
    labs[1][1] = new Label(50+w1+cG, 50+1*(h1+rG), w1, h1, "add 10 wolves", green);
    labs[1][2] = new Label(50+w1+cG, 50+2*(h1+rG), w1, h1, "add 50 wolves", green);
    labs[1][3] = new Label(50+w1+cG, 50+3*(h1+rG), w1, h1, "add 500 wolves", green);
    labs[1][4] = new Label(50+w1+cG, 50+4*(h1+rG), w1, h1, "remove 1 wolf", red);
    labs[1][5] = new Label(50+w1+cG, 50+5*(h1+rG), w1, h1, "remove 10 wolves", red);
    labs[1][6] = new Label(50+w1+cG, 50+6*(h1+rG), w1, h1, "remove 100 wolves", red);
    labs[1][7] = new Label(50+w1+cG, 50+7*(h1+rG), w1, h1, "remove all wolves", red);
    
    
    // Blue buttons on the bottom
    color blue = color(220,100,100);
    showV[0] = new Label(width-3*w1-2*cG-50,height-rG-h1,w1,h1,"dots",blue);
    showV[1] = new Label(width-2*w1-1*cG-50,height-rG-h1,w1,h1,"simple",blue);
    showV[2] = new Label(width-1*w1-50,height-rG-h1,w1,h1,"complex",blue); 
  }

  void show() {

    for (int i=0; i<2; i++) {
      for (int j=0; j<8; j++) {
        labs[i][j].show();
      }
    }
    
    for(int i=0; i<3; i++) showV[i].show();
  }

  // Which button was clicked 
  void click() {
    if (labs[0][0].mouseOver()) {
      addSheep(10);
    } else if (labs[0][1].mouseOver()) {
      addSheep(100);
    } else if (labs[0][2].mouseOver()) {
      addSheep(500);
    } else if (labs[0][3].mouseOver()) {
      addSheep(5000);
    } else if (labs[0][4].mouseOver()) {
      removeSheep(10);
    } else if (labs[0][5].mouseOver()) {
      removeSheep(100);
    } else if (labs[0][6].mouseOver()) {
      removeSheep(1000);
    } else if (labs[0][7].mouseOver()) {
      removeSheep(-1);
    } else if (labs[1][0].mouseOver()) {
      addWolves(1);
    } else if (labs[1][1].mouseOver()) {
      addWolves(10);
    } else if (labs[1][2].mouseOver()) {
      addWolves(50);
    } else if (labs[1][3].mouseOver()) {
      addWolves(500);
    } else if (labs[1][4].mouseOver()) {
      removeWolves(1);
    } else if (labs[1][5].mouseOver()) {
      removeWolves(10);
    } else if (labs[1][6].mouseOver()) {
      removeWolves(100);
    } else if (labs[1][7].mouseOver()) {
      removeWolves(-1);
    }else if (showV[0].mouseOver()) {
      showVersion=0;
    } else if (showV[1].mouseOver()) {
      showVersion=1;
    } else if (showV[2].mouseOver()) {
      showVersion=2;
    }
  }
  
  
  // Adding and removing entities 
  void addSheep(int n) {
    for (int i=0; i<n; i++) {
      sheeps.add(new Sheep());
    }
  }

  void removeSheep(int n) {
    if(n==-1)n=sheeps.size();
    for (int i=0; i<n; i++) {
      if (sheeps.size()==0) return;
      sheeps.remove(floor(random(sheeps.size())));
    }
  }

  void addWolves(int n) {
    for (int i=0; i<n; i++) {
      wolves.add(new Wolf());
    }
  }

  void removeWolves(int n) {
    if(n==-1)n=wolves.size();
    for (int i=0; i<n; i++) {
      if (wolves.size()==0) return;
      wolves.remove(floor(random(wolves.size())));
    }
  }
}
