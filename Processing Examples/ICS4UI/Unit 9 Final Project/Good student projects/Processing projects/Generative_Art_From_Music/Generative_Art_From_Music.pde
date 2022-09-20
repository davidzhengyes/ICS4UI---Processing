PImage img; // Import image library.
import ddf.minim.*; // Import Audio library.
import ddf.minim.analysis.*;
import g4p_controls.*; // Import G4P GUI tools. 

Minim music;
AudioPlayer song;
FFT fft;

int songChoice; // Declaring songChoice variable to be used later. 
String songName = "song3.mp3"; // Can be song1-song6.  
int songCurrent = 1; // Declare and assign a number to the current song playing. 

int filterType; // Declare filterType variable.

int numberOfCubes; // Number of floating cubes.
cubeFunction[] cubes; // Create array with cubeFunction class.

float spectrumHighs = 0.30;
float spectrumMedium = 0.15;
float spectrumLows = 0.05;
  
float rangeHighs;
float rangeMedium;
float rangeLows;
  
float pRangeHighs = rangeHighs;
float pRangeMedium = rangeMedium;
float pRangeLows = rangeLows;

float rangeDecrease = 30; // The decrease rate for scale + color of cubes. 


void setup(){ // Standard setup routine.

  size(800,800,P3D); // 800 by 800 Processing 3D screen. 
  background(0); // Black background. 
  img = loadImage("image.jpg"); // Loading up the image for the background. 
  img.resize(height,width); // Resize image to fit full screen. 
  frameRate(60); // Framerate. 
  
  music = new Minim(this); // Declaring as object. 
  song = music.loadFile(songName); // Loading up the song file(s). 
  fft = new FFT(song.bufferSize(), song.sampleRate());
  song.play(0); // Starts playing song here. 

  numberOfCubes = int(fft.specSize()*spectrumHighs); // Creates a set number of cubes according to the spectrum size and the highs found in the song. 
  cubes = new cubeFunction[numberOfCubes]; // Create an array with numberOfCubes length.
  
  for(int i = 0; i < cubes.length; i = i + 1) {
    cubes[i] = new cubeFunction(); // New cube for each placeholder in array. 
  }
  //createGUI(); // Creates GUI from G4P.
}

void draw(){ // Standard draw routine. 
  fft.forward(song.mix); // Move along the song per frame. 
  cubeDraw();  // Call cubeDraw function from cubeFunction class.
  
  float tiles = mouseX/6; // Number of tiles is dependent on the X postiion of the mouse.
  float tileSize = width/tiles; // The size of each tile.
  fill(255);
  
  for(int i = 0 ; i < tiles; i = i + 1){ // X circle grid.
    for(int j = 0 ; j < tiles; j = j + 1){ // Y circle grid.
      color c = img.get(int(i*tileSize),int(j*tileSize)); // Get the color of each pixel from the picture. 
      float b = map(brightness(c),0,255,0,1); // Get the brightnress of each color. 
      
      push();
      translate(i*tileSize,j*tileSize); 
      circle(0,0,tileSize*b);
      pop();
    }
  }
  

  filter(filterType); // Filter type (possible states: GRAY, TRESHOLD, INVERT or 0).
  
  if ((songChoice == 1)&&(songCurrent != 1)){ // If the song thats currently playing isn't the same one as the the song that was chosen,
      songName = ("song1.mp3");               // then play the song. This applies for all 5 songs. 
      music.stop();
      song = music.loadFile(songName);
      song.play(0);
   } else if ((songChoice == 2)&&(songCurrent != 2)){
      songName = ("song2.mp3");
      music.stop();
      song = music.loadFile(songName);
      song.play(0);
   } else if ((songChoice == 3)&&(songCurrent != 3)){
      songName = ("song3.mp3");
      music.stop();
      song = music.loadFile(songName);
      song.play(0);
   } else if ((songChoice == 4)&&(songCurrent != 4)){
      songName = ("song4.mp3");
      music.stop();
      song = music.loadFile(songName);
      song.play(0);
   } else if ((songChoice == 5)&&(songCurrent != 5)){
      songName = ("song5.mp3");
      music.stop();
      song = music.loadFile(songName);
      song.play(0);
  }
  
}
  
    
  
