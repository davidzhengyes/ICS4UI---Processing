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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:924836:
  appc.background(230);
} //_CODE_:window1:924836:

public void CGSpeed(GSlider source, GEvent event) { //_CODE_:CGSpeedSlider:671799:
  CG.speed = CGSpeedSlider.getValueI();
  pauseAnimation = true;
} //_CODE_:CGSpeedSlider:671799:

public void DASpeed(GSlider source, GEvent event) { //_CODE_:DASpeedSlider:540839:
  DA.speed = DASpeedSlider.getValueI();
  pauseAnimation = true;
} //_CODE_:DASpeedSlider:540839:

public void ResetButton(GButton source, GEvent event) { //_CODE_:Reset:700321:
  resetValues();
} //_CODE_:Reset:700321:

public void CGSLC(GSlider source, GEvent event) { //_CODE_:CGSL:890894:
  CG.strideLength = CGSL.getValueI();
  pauseAnimation = true;
} //_CODE_:CGSL:890894:

public void CGDFBC(GSlider source, GEvent event) { //_CODE_:CGDFB:561502:
  CG.startLocation = CGDFB.getValueI();
  pauseAnimation = true;
} //_CODE_:CGDFB:561502:

public void DASLC(GSlider source, GEvent event) { //_CODE_:DASL:504214:
  DA.strideLength = DASL.getValueI();
  pauseAnimation = true;
} //_CODE_:DASL:504214:

public void DADFBC(GSlider source, GEvent event) { //_CODE_:DADFB:951173:
  DA.startLocation = DADFB.getValueI();
  pauseAnimation = true;
} //_CODE_:DADFB:951173:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 400, 300, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  CGSpeedSlider = new GSlider(window1, 30, 60, 120, 50, 10.0);
  CGSpeedSlider.setShowValue(true);
  CGSpeedSlider.setShowLimits(true);
  CGSpeedSlider.setLimits(5, 1, 10);
  CGSpeedSlider.setNbrTicks(10);
  CGSpeedSlider.setNumberFormat(G4P.INTEGER, 0);
  CGSpeedSlider.setOpaque(false);
  CGSpeedSlider.addEventHandler(this, "CGSpeed");
  label1 = new GLabel(window1, 20, 30, 140, 30);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Constant Growth");
  label1.setOpaque(false);
  DASpeedSlider = new GSlider(window1, 250, 60, 120, 50, 10.0);
  DASpeedSlider.setShowValue(true);
  DASpeedSlider.setShowLimits(true);
  DASpeedSlider.setLimits(5, 1, 10);
  DASpeedSlider.setNbrTicks(10);
  DASpeedSlider.setNumberFormat(G4P.INTEGER, 0);
  DASpeedSlider.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  DASpeedSlider.setOpaque(false);
  DASpeedSlider.addEventHandler(this, "DASpeed");
  label3 = new GLabel(window1, 250, 160, 120, 30);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Stride Length");
  label3.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label3.setOpaque(false);
  label6 = new GLabel(window1, 240, 230, 140, 40);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Distance From Bridge");
  label6.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label6.setOpaque(false);
  label7 = new GLabel(window1, 20, 230, 140, 40);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Distance From Bridge");
  label7.setOpaque(false);
  label8 = new GLabel(window1, 240, 30, 140, 30);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("Doubling Algorithm");
  label8.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label8.setOpaque(false);
  Reset = new GButton(window1, 160, 110, 80, 30);
  Reset.setText("Reset");
  Reset.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  Reset.addEventHandler(this, "ResetButton");
  label5 = new GLabel(window1, 30, 90, 120, 30);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Speed");
  label5.setOpaque(false);
  CGSL = new GSlider(window1, 30, 130, 120, 50, 10.0);
  CGSL.setShowValue(true);
  CGSL.setShowLimits(true);
  CGSL.setLimits(25, 1, 50);
  CGSL.setNbrTicks(5);
  CGSL.setNumberFormat(G4P.INTEGER, 0);
  CGSL.setOpaque(false);
  CGSL.addEventHandler(this, "CGSLC");
  CGDFB = new GSlider(window1, 30, 200, 120, 40, 10.0);
  CGDFB.setShowValue(true);
  CGDFB.setShowLimits(true);
  CGDFB.setLimits(500, 85, 600);
  CGDFB.setNumberFormat(G4P.INTEGER, 0);
  CGDFB.setOpaque(false);
  CGDFB.addEventHandler(this, "CGDFBC");
  DASL = new GSlider(window1, 250, 130, 120, 50, 10.0);
  DASL.setShowValue(true);
  DASL.setShowLimits(true);
  DASL.setLimits(25, 1, 50);
  DASL.setNumberFormat(G4P.INTEGER, 0);
  DASL.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  DASL.setOpaque(false);
  DASL.addEventHandler(this, "DASLC");
  DADFB = new GSlider(window1, 250, 200, 120, 40, 10.0);
  DADFB.setShowValue(true);
  DADFB.setShowLimits(true);
  DADFB.setLimits(500, 85, 600);
  DADFB.setNumberFormat(G4P.INTEGER, 0);
  DADFB.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  DADFB.setOpaque(false);
  DADFB.addEventHandler(this, "DADFBC");
  label2 = new GLabel(window1, 30, 160, 120, 30);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Stride Length");
  label2.setOpaque(false);
  label4 = new GLabel(window1, 250, 90, 120, 30);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Speed");
  label4.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label4.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GSlider CGSpeedSlider; 
GLabel label1; 
GSlider DASpeedSlider; 
GLabel label3; 
GLabel label6; 
GLabel label7; 
GLabel label8; 
GButton Reset; 
GLabel label5; 
GSlider CGSL; 
GSlider CGDFB; 
GSlider DASL; 
GSlider DADFB; 
GLabel label2; 
GLabel label4; 
