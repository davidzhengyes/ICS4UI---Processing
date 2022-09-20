//Kieran Nieva ~ SnowStorm
PImage img;

//choose the mode you want to use 
String [] modes = {"snow.png", "cherry.png", "sjam.png", "volcano.png"};
//Try replacing snow.png or cherry.png with MR_S_DANDRUFF.png to tell Mr S that he needs to find a new conditioner lol

//PICK THE INDEX OF THE MODE YOU WANT TO USE
int modeChoice = 2;

// for loading in snow colour and speed based off of mode picked
color [] colorC = {color(255), color(255, 135, 231), color(255), color(180) };
float[] snowSpeed = {5, 3, 5, 2};

// For snow colour
color snowC = colorC[modeChoice];

// how often new snow falls and at what speed
float snowInt = 1; //the higher the number is, the less snow falls
float snowS = snowSpeed[modeChoice];

Snow snow;
BottomStack stack;



void setup() {
    //Setup
    img = loadImage(modes[modeChoice] );
    size(612,400);
    frameRate(20);
    
    snow = new Snow();
    stack = new BottomStack();
}

//Main draw Function
void draw() {

    //Drawing background image
    background(img);

    //Drawing existing flakes in new positions
    snow.draw();
    
    //Drawing snow stack at the bottom
    stack.draw();
    
    //Creating New snowflakes
    snow.newSnow(snowInt);
    
    //Checking if its landed 
    snow.ifLanded(stack);
}
