void drawDeck( int iSwap ) {
  
  if( animationType.equals( "linear" ))
    for(int i=0; i < n; i++) {
      if( i == iSwap )
        sortableDeck[i].x = i*gap + motionProgress;
      
      else if( i == iSwap + 1 )
        sortableDeck[i].x = i*gap - motionProgress;
      
      else
        sortableDeck[i].x = i*gap;
             
      sortableDeck[i].drawMe();
    }
  
  if( animationType.equals( "circular" )) {
    for(int i=0; i < n; i++) {
      if( i == iSwap ) {
        sortableDeck[i].x = i*gap + radius*(-cos(motionProgress)+1);
        sortableDeck[i].y = midHeight - radius*sin(motionProgress);
      }
      
      else if( i == iSwap + 1 ) {
        sortableDeck[i].x = i*gap + radius*(cos(motionProgress)-1);
        sortableDeck[i].y = midHeight + radius*sin(motionProgress);
      }
      
      else {
        sortableDeck[i].x = i*gap;
        sortableDeck[i].y = midHeight;
      }
             
      sortableDeck[i].drawMe();
    }
  }  
}


void setDeltaX(){
  if( animationType.equals("linear"))
    deltaX = gap/framesPerSwap;
    
  else
    deltaX = PI/framesPerSwap;
}


void setGap() {
  PImage testImg = loadImage("2_of_clubs.png");
  int imgWidth = testImg.width/scaleReductionFactor;
  gap = (width-imgWidth)/(n-1);
}


void shuffleDeck() {
  for(int p = 1; p <= n-1; p++) {
    for(int i = 0; i <= n-p-1; i++) {
      if( originalDeck[i].randomizedValue > originalDeck[i+1].randomizedValue ) {
        Card frog = originalDeck[i];
        originalDeck[i] = originalDeck[i+1];
        originalDeck[i+1] = frog;
      }    
    }
  }
  //for(int i=0; i < n; i++) 
  //  println(originalDeck[i].name, originalDeck[i].sortValue);
}



void readCardImages() {
  String myProjectPath = sketchPath();
  File f = new File( myProjectPath + "/data" );
  
  String[] fileNames = f.list();
  
  int i = 0;
  
  for(int j=0; j < n; j++) {
    String cardFileName = fileNames[j];
    if( !cardFileName.equals(".DS_Store") ) {
      PImage cardImg = loadImage(cardFileName);
      originalDeck[i] = new Card(i*gap, midHeight, cardImg, cardFileName); 
      i++;
    }
  }
}


void setImageSizes() {
  int w = originalDeck[0].img.width;
  int h = originalDeck[0].img.height;
  cardWidth = w/scaleReductionFactor;
  cardHeight = h/scaleReductionFactor;
}


void swap( int i ) {
  Card f = sortableDeck[i];
  sortableDeck[i] = sortableDeck[i + 1];
  sortableDeck[i + 1] = f; 
}
