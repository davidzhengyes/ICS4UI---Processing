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

public void speedSliderDragged(GCustomSlider source, GEvent event) { //_CODE_:speedSlider:747181:
  println("speedSlider - GCustomSlider >> GEvent." + event + " @ " + millis());
  println(speedSlider.getValueF());
  xSpeed = speedSlider.getValueF();
  
} //_CODE_:speedSlider:747181:

public void radiusSliderDrag(GCustomSlider source, GEvent event) { //_CODE_:radiusSlider:977309:
  println("radiusSlider - GCustomSlider >> GEvent." + event + " @ " + millis());
  r=radiusSlider.getValueF();
} //_CODE_:radiusSlider:977309:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:window1:289604:
  appc.background(230);
} //_CODE_:window1:289604:

public void custom_slider1_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider1:378438:
  println("custom_slider1 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider1:378438:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  speedSlider = new GCustomSlider(this, 60, 68, 288, 67, "grey_blue");
  speedSlider.setLimits(0.5, 0.0, 10.0);
  speedSlider.setNumberFormat(G4P.DECIMAL, 2);
  speedSlider.setOpaque(false);
  speedSlider.addEventHandler(this, "speedSliderDragged");
  radiusSlider = new GCustomSlider(this, 171, 150, 100, 40, "grey_blue");
  radiusSlider.setLimits(2.0, 2.0, 60.0);
  radiusSlider.setNumberFormat(G4P.DECIMAL, 2);
  radiusSlider.setOpaque(false);
  radiusSlider.addEventHandler(this, "radiusSliderDrag");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 120, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw2");
  custom_slider1 = new GCustomSlider(window1, 70, 40, 100, 40, "grey_blue");
  custom_slider1.setLimits(0.5, 0.0, 1.0);
  custom_slider1.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider1.setOpaque(false);
  custom_slider1.addEventHandler(this, "custom_slider1_change1");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GCustomSlider speedSlider; 
GCustomSlider radiusSlider; 
GWindow window1;
GCustomSlider custom_slider1; 
