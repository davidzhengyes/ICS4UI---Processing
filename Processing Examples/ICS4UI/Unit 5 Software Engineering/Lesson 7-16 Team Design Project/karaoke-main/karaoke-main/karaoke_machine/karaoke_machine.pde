import g4p_controls.*;
import processing.sound.*;
import processing.core.PApplet;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

static final int BANDS = 2048;
static final String[] pics = {"MR_S_ARMUP.png", "MR_S_ARMMID.png", "MR_S_ARMDOWN.png", "MR_S_ARMMID.png"};
static final String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
static final int space = 340;

PFont candara;
Map<Float, String> frequencyTable;
PImage mainMenuBackground, karaokeBackground, gameOverBackground;
int currentPic = 0;
String note, previousNote;
List<PVector> movingNotes = new ArrayList<PVector>();
List<String> noteName = new ArrayList<String>();
String[] lyricText;
float[] lyricBeatCue;
float micFrequency, songFrequency;
String micNote, songNote;
float accuracySum;
int divisor;
String gameState;
float vol = 1.0;
boolean paused = false;
String choice;

Microphone mic;
Song song;
Song littleLamb;
Song belongWithMe;
Song foreverLikeThat;

void setup() {
  size(512, 450);
  frameRate(30);
  textAlign(CENTER);
  
  candara = createFont("Candara", 40);
  textFont(candara);
  
  mainMenuBackground = loadImage("Curtains img 1.jpg");
  karaokeBackground = loadImage(pics[currentPic]);
  gameOverBackground = loadImage("Game over.png");
  
  frequencyTable = generateFrequencyTable();
  loadSongs();
  createGUI();
  displayMainMenu();
}

void draw() {
  if (gameState == "menu") {
    background(mainMenuBackground);
    text("Karaoke Hero", 253, 170);
  } else if (gameState == "play") {
    if (!paused && !song.isPlaying() && movingNotes.size() == 0) {
        displayGameOver();
    }
    
    if (!paused) {
      changeBackground();
      showNotes();
    }
    
    micFrequency = mic.getFrequency();
    songFrequency = song.getFrequency();
    micNote = mic.getClosestNote(micFrequency);
    songNote = song.getClosestNote(songFrequency);
    song.compare(mic);
    findNote();
    drawLyrics(song);
  } else if (gameState == "game over") {
      image(gameOverBackground, 0, 0);
      text("Congrats! Your accuracy was: " + round(getAverageAccuracy()) + "%", 253, 320);
  }
}

/*
* Returns a hashmap of frequencies to the corresponding pitches.
*/
public Map<Float, String> generateFrequencyTable() {
  Map<Float, String> table = new HashMap<Float, String>();
  BufferedReader reader = createReader("freq_to_note.txt");
  String line;

  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      String note = pieces[0];
      float freq = float(pieces[1]);
      table.put(freq, note);
    }
  }
  catch (IOException e) {
  }

  return table;
}

/*
* Returns the index of the max value in an array of floats.
*/
public int argMax(float[] vals) {
  int maxIndex = 0;
  float max = 0;

  for (int i = 0; i < vals.length; i++) {
    if (vals[i] > max) {
      maxIndex = i;
      max = vals[i];
    }
  }

  return maxIndex;
}

/*
* Cycles the background when in the karaoke screen.
*/
public void changeBackground() {
  image(karaokeBackground, 0, 0);
  int changesPerMin = round(frameRate*60/song.bpm);

  if (frameCount % changesPerMin == 0) {
    currentPic++;
    karaokeBackground = loadImage(pics[currentPic%4]);
  }
}

/*
* Returns the average accuracy as a float.
*/
public float getAverageAccuracy() {
  return accuracySum / divisor;
}

/*
* Initializes songs.
*/
public void loadSongs() {
  littleLamb = new Song(this, "Little Lamb Melody.wav", "Little Lamb Accompaniment.wav", "Little Lamb Lyrics.txt", 85);
  littleLamb.stop();
  belongWithMe = new Song(this, "Belong With Me Melody.wav", "Belong With Me Accompaniment.wav", "Belong With Me Lyrics.txt", 130);
  belongWithMe.stop();
  foreverLikeThat = new Song(this, "Forever Like That Melody.wav", "Forever Like That Accompaniment.wav", "Forever Like That Lyrics.txt", 115);
  foreverLikeThat.stop();
}
