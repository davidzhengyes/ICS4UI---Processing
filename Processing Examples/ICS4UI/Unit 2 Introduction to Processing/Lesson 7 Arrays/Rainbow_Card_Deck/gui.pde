/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:205244:
  appc.background(230);
} //_CODE_:window1:205244:

public void nSliderChanged(GSlider source, GEvent event) { //_CODE_:nSlider:263435:
  resetValues();
} //_CODE_:nSlider:263435:

public void colourListChanged(GDropList source, GEvent event) { //_CODE_:colourList:767293:
  resetValues();
} //_CODE_:colourList:767293:

public void speedSliderChanged(GSlider source, GEvent event) { //_CODE_:speedSlider:583977:
  resetValues();
} //_CODE_:speedSlider:583977:

public void shapeButtonClicked(GButton source, GEvent event) { //_CODE_:shapeButton:985598:
  if(shape.equals("squares")) {
    shape = "ovals";
    shapeButton.setText("Squares");
  }
  else {
    shape = "squares";
    shapeButton.setText("Ovals");
  }
  resetValues();

} //_CODE_:shapeButton:985598:

public void offsetSliderChanged(GSlider source, GEvent event) { //_CODE_:offsetSlider:358749:
  resetValues();
} //_CODE_:offsetSlider:358749:

public void insideButtonClicked(GButton source, GEvent event) { //_CODE_:insideButton:910381:
  if(insideFaster)
    insideButton.setText("Inside spins faster");
    
  else
    insideButton.setText("Outside spins faster");  
  
  insideFaster = !insideFaster;
  resetValues();
} //_CODE_:insideButton:910381:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 350, 300, JAVA2D);
  window1.noLoop();
  window1.addDrawHandler(this, "win_draw1");
  label1 = new GLabel(window1, 10, 40, 110, 20);
  label1.setText("Number of shapes");
  label1.setOpaque(false);
  nSlider = new GSlider(window1, 120, 30, 210, 40, 10.0);
  nSlider.setLimits(1, 1, 9);
  nSlider.setNbrTicks(9);
  nSlider.setStickToTicks(true);
  nSlider.setNumberFormat(G4P.INTEGER, 0);
  nSlider.setOpaque(false);
  nSlider.addEventHandler(this, "nSliderChanged");
  label2 = new GLabel(window1, 10, 150, 80, 20);
  label2.setText("Color scheme");
  label2.setOpaque(false);
  colourList = new GDropList(window1, 100, 150, 90, 100, 4);
  colourList.setItems(loadStrings("list_767293"), 0);
  colourList.addEventHandler(this, "colourListChanged");
  label3 = new GLabel(window1, 10, 100, 50, 20);
  label3.setText("Speed");
  label3.setOpaque(false);
  speedSlider = new GSlider(window1, 60, 90, 140, 40, 10.0);
  speedSlider.setShowValue(true);
  speedSlider.setLimits(1, 1, 8);
  speedSlider.setNbrTicks(8);
  speedSlider.setStickToTicks(true);
  speedSlider.setNumberFormat(G4P.INTEGER, 0);
  speedSlider.setOpaque(false);
  speedSlider.addEventHandler(this, "speedSliderChanged");
  shapeButton = new GButton(window1, 10, 190, 80, 30);
  shapeButton.setText("Ovals");
  shapeButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  shapeButton.addEventHandler(this, "shapeButtonClicked");
  label4 = new GLabel(window1, 10, 240, 140, 20);
  label4.setText("Offset centre of rotation");
  label4.setOpaque(false);
  offsetSlider = new GSlider(window1, 150, 230, 160, 40, 10.0);
  offsetSlider.setLimits(0, 0, 100);
  offsetSlider.setNumberFormat(G4P.INTEGER, 0);
  offsetSlider.setOpaque(false);
  offsetSlider.addEventHandler(this, "offsetSliderChanged");
  insideButton = new GButton(window1, 110, 190, 80, 30);
  insideButton.setText("Outside spins faster");
  insideButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  insideButton.addEventHandler(this, "insideButtonClicked");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GLabel label1; 
GSlider nSlider; 
GLabel label2; 
GDropList colourList; 
GLabel label3; 
GSlider speedSlider; 
GButton shapeButton; 
GLabel label4; 
GSlider offsetSlider; 
GButton insideButton; 
