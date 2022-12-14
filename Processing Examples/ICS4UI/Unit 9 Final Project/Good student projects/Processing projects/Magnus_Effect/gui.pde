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

synchronized public void renderControlWindow(PApplet appc, GWinData data) { //_CODE_:controlWindow:504271:
  appc.background(230);
} //_CODE_:controlWindow:504271:

public void exampleListClick(GDropList source, GEvent event) { //_CODE_:exampleList:825268:
  //set gui controllers to values for example pitches
  int selectIndex = exampleList.getSelectedIndex();
  switch (selectIndex) {
    case 0:  //fastball
      setControllerValues(new PVector(-3.6, 70, -1), 105, new PVector (4, 0, 1), 0.5);
      break;
    case 1:  //curveball
      setControllerValues(new PVector(2, 25, 2), 86, new PVector (-1, -1, 2.5), 2);
      break;
    case 2:  //screwball
      setControllerValues(new PVector(-8, 50, -6), 86, new PVector (2, -1, -1), 2.4);
      break;
    case 3:  //no spin
      setControllerValues(new PVector(-4, 60, 0), 94, new PVector (0, 0, 0), 0);
      break;
    case 4:  //top spin
      setControllerValues(new PVector(-1.5, 70, 8), 86, new PVector (-4, 0, 1), 1.8);
      break;
  }
} //_CODE_:exampleList:825268:

public void handCheckboxClicked(GCheckbox source, GEvent event) { //_CODE_:handCheckbox:819723:
  initialPosition.x *= -1;
} //_CODE_:handCheckbox:819723:

public void initialSpeedSliderChanged(GSlider source, GEvent event) { //_CODE_:initialSpeedSlider:678045:
  initialSpeedMPH = initialSpeedSlider.getValueF();
} //_CODE_:initialSpeedSlider:678045:

public void xVelocitySliderChanged(GSlider source, GEvent event) { //_CODE_:xVelocitySlider:217240:
  initialVelocity.x = xVelocitySlider.getValueF();
} //_CODE_:xVelocitySlider:217240:

public void yVelocitySliderChanged(GSlider source, GEvent event) { //_CODE_:yVelocitySlider:287356:
  initialVelocity.y = yVelocitySlider.getValueF();
} //_CODE_:yVelocitySlider:287356:

public void zVelocitySliderChanged(GSlider source, GEvent event) { //_CODE_:zVelocitySlider:596705:
  initialVelocity.z = zVelocitySlider.getValueF();
} //_CODE_:zVelocitySlider:596705:

public void spinDirectionCheckboxChanged(GCheckbox source, GEvent event) { //_CODE_:spinDirectionCheckbox:866291:
  axisRotation.mult(-1);
} //_CODE_:spinDirectionCheckbox:866291:

public void xAxisSliderChanged(GSlider source, GEvent event) { //_CODE_:xAxisSlider:513863:
  axisRotation.x = xAxisSlider.getValueF();
} //_CODE_:xAxisSlider:513863:

public void yAxisSliderChanged(GSlider source, GEvent event) { //_CODE_:yAxisSlider:765921:
  axisRotation.y = yAxisSlider.getValueF();
} //_CODE_:yAxisSlider:765921:

public void zAxisSliderChanged(GSlider source, GEvent event) { //_CODE_:zAxisSlider:878260:
  axisRotation.z = zAxisSlider.getValueF();
} //_CODE_:zAxisSlider:878260:

public void spinSpeedSliderChanged(GSlider source, GEvent event) { //_CODE_:spinSpeedSlider:959148:
  revolutionPS = spinSpeedSlider.getValueF();
} //_CODE_:spinSpeedSlider:959148:

public void pauseButtonChanged(GButton source, GEvent event) { //_CODE_:pauseButton:371373:
  if (start == false) {
    start = true;
  }
  else {
    pause = !pause;
    if(pause) {
      pauseButton.setText("START");
    }
    else {
      pauseButton.setText("PAUSE");
    }
  }
  
  
} //_CODE_:pauseButton:371373:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  controlWindow = GWindow.getWindow(this, "Control Window", 0, 0, 300, 500, JAVA2D);
  controlWindow.noLoop();
  controlWindow.addDrawHandler(this, "renderControlWindow");
  exampleList = new GDropList(controlWindow, 100, 30, 90, 80, 3);
  exampleList.setItems(loadStrings("list_825268"), 0);
  exampleList.addEventHandler(this, "exampleListClick");
  handCheckbox = new GCheckbox(controlWindow, 200, 460, 90, 30);
  handCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  handCheckbox.setText("Left-handed");
  handCheckbox.setOpaque(false);
  handCheckbox.addEventHandler(this, "handCheckboxClicked");
  initialSpeedSlider = new GSlider(controlWindow, 100, 440, 100, 20, 10.0);
  initialSpeedSlider.setLimits(86, 64, 108);
  initialSpeedSlider.setNbrTicks(6);
  initialSpeedSlider.setNumberFormat(G4P.INTEGER, 0);
  initialSpeedSlider.setOpaque(false);
  initialSpeedSlider.addEventHandler(this, "initialSpeedSliderChanged");
  initialSpeedLabel = new GLabel(controlWindow, 90, 410, 120, 20);
  initialSpeedLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  initialSpeedLabel.setText("Pitch Speed");
  initialSpeedLabel.setOpaque(false);
  exampleLabel = new GLabel(controlWindow, 110, 10, 80, 20);
  exampleLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  exampleLabel.setText("Examples");
  exampleLabel.setOpaque(false);
  xVelocitySlider = new GSlider(controlWindow, 10, 370, 80, 20, 10.0);
  xVelocitySlider.setLimits(0.0, -10.0, 10.0);
  xVelocitySlider.setNbrTicks(3);
  xVelocitySlider.setShowTicks(true);
  xVelocitySlider.setNumberFormat(G4P.DECIMAL, 2);
  xVelocitySlider.setOpaque(false);
  xVelocitySlider.addEventHandler(this, "xVelocitySliderChanged");
  yVelocitySlider = new GSlider(controlWindow, 110, 370, 80, 20, 10.0);
  yVelocitySlider.setLimits(100.0, 0.0, 100.0);
  yVelocitySlider.setNbrTicks(3);
  yVelocitySlider.setShowTicks(true);
  yVelocitySlider.setNumberFormat(G4P.DECIMAL, 2);
  yVelocitySlider.setOpaque(false);
  yVelocitySlider.addEventHandler(this, "yVelocitySliderChanged");
  zVelocitySlider = new GSlider(controlWindow, 210, 370, 80, 20, 10.0);
  zVelocitySlider.setLimits(0.0, -10.0, 10.0);
  zVelocitySlider.setNbrTicks(3);
  zVelocitySlider.setShowTicks(true);
  zVelocitySlider.setNumberFormat(G4P.DECIMAL, 2);
  zVelocitySlider.setOpaque(false);
  zVelocitySlider.addEventHandler(this, "zVelocitySliderChanged");
  xVelocityLabel = new GLabel(controlWindow, 10, 330, 80, 30);
  xVelocityLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  xVelocityLabel.setText("X Velocity Direction");
  xVelocityLabel.setOpaque(false);
  yVelocityLabel = new GLabel(controlWindow, 110, 330, 80, 30);
  yVelocityLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  yVelocityLabel.setText("Y-Velocity Direction");
  yVelocityLabel.setOpaque(false);
  zVelocityLabel = new GLabel(controlWindow, 210, 330, 80, 30);
  zVelocityLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  zVelocityLabel.setText("Z-Velocity Direction");
  zVelocityLabel.setOpaque(false);
  spinDirectionCheckbox = new GCheckbox(controlWindow, 210, 280, 80, 20);
  spinDirectionCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  spinDirectionCheckbox.setText("Clockwise");
  spinDirectionCheckbox.setOpaque(false);
  spinDirectionCheckbox.addEventHandler(this, "spinDirectionCheckboxChanged");
  xAxisSlider = new GSlider(controlWindow, 10, 150, 80, 20, 10.0);
  xAxisSlider.setLimits(0.0, -10.0, 10.0);
  xAxisSlider.setNbrTicks(3);
  xAxisSlider.setShowTicks(true);
  xAxisSlider.setNumberFormat(G4P.DECIMAL, 2);
  xAxisSlider.setOpaque(false);
  xAxisSlider.addEventHandler(this, "xAxisSliderChanged");
  yAxisSlider = new GSlider(controlWindow, 110, 150, 80, 20, 10.0);
  yAxisSlider.setLimits(0.0, -10.0, 10.0);
  yAxisSlider.setNbrTicks(3);
  yAxisSlider.setShowTicks(true);
  yAxisSlider.setNumberFormat(G4P.DECIMAL, 2);
  yAxisSlider.setOpaque(false);
  yAxisSlider.addEventHandler(this, "yAxisSliderChanged");
  zAxisSlider = new GSlider(controlWindow, 210, 150, 80, 20, 10.0);
  zAxisSlider.setLimits(0.0, -10.0, 10.0);
  zAxisSlider.setNbrTicks(3);
  zAxisSlider.setShowTicks(true);
  zAxisSlider.setNumberFormat(G4P.DECIMAL, 2);
  zAxisSlider.setOpaque(false);
  zAxisSlider.addEventHandler(this, "zAxisSliderChanged");
  xAxisLabel = new GLabel(controlWindow, 10, 110, 80, 30);
  xAxisLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  xAxisLabel.setText("X-Axis of Rotation");
  xAxisLabel.setOpaque(false);
  yAxisRotationLable = new GLabel(controlWindow, 110, 110, 80, 30);
  yAxisRotationLable.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  yAxisRotationLable.setText("Y-Axis of Rotation");
  yAxisRotationLable.setOpaque(false);
  zAxisRotation = new GLabel(controlWindow, 210, 110, 80, 30);
  zAxisRotation.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  zAxisRotation.setText("Z-Axis of Rotation");
  zAxisRotation.setOpaque(false);
  spinSpeedSlider = new GSlider(controlWindow, 100, 230, 100, 20, 10.0);
  spinSpeedSlider.setLimits(0.5, 0.0, 3.0);
  spinSpeedSlider.setNbrTicks(3);
  spinSpeedSlider.setShowTicks(true);
  spinSpeedSlider.setNumberFormat(G4P.DECIMAL, 2);
  spinSpeedSlider.setOpaque(false);
  spinSpeedSlider.addEventHandler(this, "spinSpeedSliderChanged");
  spinSpeedLabel = new GLabel(controlWindow, 110, 200, 80, 20);
  spinSpeedLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  spinSpeedLabel.setText("Spin Speed");
  spinSpeedLabel.setOpaque(false);
  pauseButton = new GButton(controlWindow, 210, 20, 70, 30);
  pauseButton.setText("START");
  pauseButton.addEventHandler(this, "pauseButtonChanged");
  controlWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow controlWindow;
GDropList exampleList; 
GCheckbox handCheckbox; 
GSlider initialSpeedSlider; 
GLabel initialSpeedLabel; 
GLabel exampleLabel; 
GSlider xVelocitySlider; 
GSlider yVelocitySlider; 
GSlider zVelocitySlider; 
GLabel xVelocityLabel; 
GLabel yVelocityLabel; 
GLabel zVelocityLabel; 
GCheckbox spinDirectionCheckbox; 
GSlider xAxisSlider; 
GSlider yAxisSlider; 
GSlider zAxisSlider; 
GLabel xAxisLabel; 
GLabel yAxisRotationLable; 
GLabel zAxisRotation; 
GSlider spinSpeedSlider; 
GLabel spinSpeedLabel; 
GButton pauseButton; 