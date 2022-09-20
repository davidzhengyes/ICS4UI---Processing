int n = 20;
String sortingAlgo = "insertion sort"; //"insertion sort" or "bubble sort"
String animationType = "circular";     //"linear" or "circular"
int speed = 120;

Card[] originalDeck = new Card[n];
Card[] sortableDeck;
int cardWidth, cardHeight;
int scaleReductionFactor = 3;
int t = 0;
ArrayList<Integer> swapIndices = new ArrayList<Integer>();
float gap, radius;
int framesPerSwap = 15;
float deltaX;  // = gap/framesPerSwap 
float deltaTheta = PI/framesPerSwap;
float motionProgress = 0.0; 
int indexToBeSwapped = 0;
int midHeight;


void setup() {
  size(1400,400);
  frameRate( speed );
  midHeight = height/2;
  
  setGap();
  setDeltaX(); 
  radius = gap/2;

  readCardImages();
  setImageSizes();
  shuffleDeck();
  sortableDeck = originalDeck.clone();
  sortDeck();
  
  indexToBeSwapped = swapIndices.get( t );
}


void draw() {  
  background(255);
  
  if( t < swapIndices.size() ) {
    drawDeck( indexToBeSwapped );
    
    if( animationType.equals("linear")) {
      motionProgress += deltaX;
      
      if( motionProgress >= gap ) {
        swap( indexToBeSwapped );
        motionProgress = 0;
        t++;
        if( t < swapIndices.size() )
          indexToBeSwapped = swapIndices.get( t );
      }
    }
      
    else { //...if animationType == "circular"
      motionProgress += deltaTheta;
      
      if( motionProgress >= PI ) {
        swap( indexToBeSwapped );
        motionProgress = 0;
        t++;
        if( t < swapIndices.size() )
          indexToBeSwapped = swapIndices.get( t );
      }
    }
  }
      
  else{
    drawDeck(indexToBeSwapped);  
    noLoop();
  }
}


void sortDeck() {
  if( sortingAlgo.equals("bubble sort"))
    for(int p=1; p <= n-1; p++) {
      for(int i=0; i <= n-p-1; i++) {
        if( originalDeck[i].sortValue > originalDeck[i+1].sortValue ) {
          Card frog = originalDeck[i];
          originalDeck[i] = originalDeck[i+1];
          originalDeck[i+1] = frog;
          swapIndices.add(i);
        }    
      }
    }
  
  else if( sortingAlgo.equals("insertion sort"))
    for(int h = 1; h < n; h++) {
      int c = h;
      while( c > 0 &&  originalDeck[c-1].sortValue > originalDeck[c].sortValue ) {
          Card frog = originalDeck[c-1];
          originalDeck[c-1] = originalDeck[c];
          originalDeck[c] = frog;
          swapIndices.add(c-1);
          
          c--;
      }    
    }
}
 
