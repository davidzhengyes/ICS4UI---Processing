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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:controls:283426:
  appc.background(230);
} //_CODE_:controls:283426:

public void threshold_value_changed(GSlider source, GEvent event) { //_CODE_:threshold_value:997025:
  println("threshold_value - GSlider >> GEvent." + event + " @ " + millis());
  thresholdValue = source.getValueF();
  updateSettings(true);
} //_CODE_:threshold_value:997025:

public void scaleY_change1(GTextField source, GEvent event) { //_CODE_:scaleY:330721:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
  noiseScale.y = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:scaleY:330721:

public void scaleZ_change1(GTextField source, GEvent event) { //_CODE_:scaleZ:596693:
  println("scaleZ - GTextField >> GEvent." + event + " @ " + millis());
  noiseScale.z = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:scaleZ:596693:

public void binary_noise_clicked1(GCheckbox source, GEvent event) { //_CODE_:binaryNoise:201520:
  println("checkbox1 - GCheckbox >> GEvent." + event + " @ " + millis());
  useBinaryNoise = !useBinaryNoise;
  updateSettings(true);
} //_CODE_:binaryNoise:201520:

public void scaleX_change1(GTextField source, GEvent event) { //_CODE_:scaleX:901410:
  println("scaleX - GTextField >> GEvent." + event + " @ " + millis());
  noiseScale.x = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:scaleX:901410:

public void offsetX_change1(GTextField source, GEvent event) { //_CODE_:offsetX:278627:
  println("offsetX - GTextField >> GEvent." + event + " @ " + millis());
  noiseOffset.x = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:offsetX:278627:

public void offsetY_change1(GTextField source, GEvent event) { //_CODE_:offsetY:974765:
  println("offsetY - GTextField >> GEvent." + event + " @ " + millis());
  noiseOffset.y = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:offsetY:974765:

public void offsetZ_change1(GTextField source, GEvent event) { //_CODE_:offsetZ:719884:
  println("offsetZ - GTextField >> GEvent." + event + " @ " + millis());
  noiseOffset.z = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:offsetZ:719884:

public void mSizeX_change1(GTextField source, GEvent event) { //_CODE_:mSizeX:597412:
  println("mSizeX - GTextField >> GEvent." + event + " @ " + millis());
  meshSize.x = Float.parseFloat(source.getText());
  updateSettings(false);
} //_CODE_:mSizeX:597412:

public void mSizeY_change1(GTextField source, GEvent event) { //_CODE_:mSizeY:827609:
  println("mSizeY - GTextField >> GEvent." + event + " @ " + millis());
  meshSize.y = Float.parseFloat(source.getText());
  updateSettings(false);
} //_CODE_:mSizeY:827609:

public void mSizeZ_change1(GTextField source, GEvent event) { //_CODE_:mSizeZ:403186:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
  meshSize.z = Float.parseFloat(source.getText());
  updateSettings(false);
} //_CODE_:mSizeZ:403186:

public void mDimX_change1(GTextField source, GEvent event) { //_CODE_:mDimX:634773:
  println("mDimX - GTextField >> GEvent." + event + " @ " + millis());
  meshDimensions.x = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:mDimX:634773:

public void mDimY_change1(GTextField source, GEvent event) { //_CODE_:mDimY:369351:
  println("mDimY - GTextField >> GEvent." + event + " @ " + millis());
  meshDimensions.y = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:mDimY:369351:

public void mDimZ_change1(GTextField source, GEvent event) { //_CODE_:mDimZ:717558:
  println("mDimZ - GTextField >> GEvent." + event + " @ " + millis());
  meshDimensions.z = Float.parseFloat(source.getText());
  updateSettings(true);
} //_CODE_:mDimZ:717558:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  controls = GWindow.getWindow(this, "controls", 0, 0, 240, 360, JAVA2D);
  controls.noLoop();
  controls.setActionOnClose(G4P.KEEP_OPEN);
  controls.addDrawHandler(this, "win_draw1");
  threshold_value = new GSlider(controls, 110, 45, 100, 20, 10.0);
  threshold_value.setLimits(0.5, 0.0, 1.0);
  threshold_value.setNumberFormat(G4P.DECIMAL, 2);
  threshold_value.setOpaque(false);
  threshold_value.addEventHandler(this, "threshold_value_changed");
  title1 = new GLabel(controls, 5, 10, 80, 30);
  title1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  title1.setText("Noise Settings");
  title1.setOpaque(false);
  setting1 = new GLabel(controls, 3, 45, 120, 20);
  setting1.setText("Threshold Value");
  setting1.setOpaque(false);
  setting3 = new GLabel(controls, 3, 95, 80, 20);
  setting3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  setting3.setText("Noise Scale");
  setting3.setOpaque(false);
  scaleY = new GTextField(controls, 130, 95, 40, 20, G4P.SCROLLBARS_NONE);
  scaleY.setText("1");
  scaleY.setOpaque(true);
  scaleY.addEventHandler(this, "scaleY_change1");
  scaleZ = new GTextField(controls, 175, 95, 40, 20, G4P.SCROLLBARS_NONE);
  scaleZ.setText("1");
  scaleZ.setOpaque(true);
  scaleZ.addEventHandler(this, "scaleZ_change1");
  setting2 = new GLabel(controls, 3, 70, 80, 20);
  setting2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  setting2.setText("Smooth Mesh");
  setting2.setOpaque(false);
  binaryNoise = new GCheckbox(controls, 85, 70, 20, 20);
  binaryNoise.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  binaryNoise.setOpaque(false);
  binaryNoise.addEventHandler(this, "binary_noise_clicked1");
  scaleX = new GTextField(controls, 85, 95, 40, 20, G4P.SCROLLBARS_NONE);
  scaleX.setText("1");
  scaleX.setOpaque(true);
  scaleX.addEventHandler(this, "scaleX_change1");
  setting4 = new GLabel(controls, 3, 120, 80, 20);
  setting4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  setting4.setText("Noise Offset");
  setting4.setOpaque(false);
  offsetX = new GTextField(controls, 85, 120, 40, 20, G4P.SCROLLBARS_NONE);
  offsetX.setText("0");
  offsetX.setOpaque(true);
  offsetX.addEventHandler(this, "offsetX_change1");
  offsetY = new GTextField(controls, 130, 120, 40, 20, G4P.SCROLLBARS_NONE);
  offsetY.setText("0");
  offsetY.setOpaque(true);
  offsetY.addEventHandler(this, "offsetY_change1");
  offsetZ = new GTextField(controls, 175, 120, 40, 20, G4P.SCROLLBARS_NONE);
  offsetZ.setText("0");
  offsetZ.setOpaque(true);
  offsetZ.addEventHandler(this, "offsetZ_change1");
  title2 = new GLabel(controls, 3, 150, 80, 30);
  title2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  title2.setText("Mesh Settings");
  title2.setOpaque(false);
  setting5 = new GLabel(controls, 3, 185, 80, 20);
  setting5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  setting5.setText("Mesh Scale");
  setting5.setOpaque(false);
  mSizeX = new GTextField(controls, 85, 185, 40, 20, G4P.SCROLLBARS_NONE);
  mSizeX.setText("5");
  mSizeX.setOpaque(true);
  mSizeX.addEventHandler(this, "mSizeX_change1");
  mSizeY = new GTextField(controls, 130, 185, 40, 20, G4P.SCROLLBARS_NONE);
  mSizeY.setText("5");
  mSizeY.setOpaque(true);
  mSizeY.addEventHandler(this, "mSizeY_change1");
  mSizeZ = new GTextField(controls, 175, 185, 40, 20, G4P.SCROLLBARS_NONE);
  mSizeZ.setText("5");
  mSizeZ.setOpaque(true);
  mSizeZ.addEventHandler(this, "mSizeZ_change1");
  setting6 = new GLabel(controls, 3, 210, 80, 25);
  setting6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  setting6.setText("Mesh Dimensions");
  setting6.setOpaque(false);
  mDimX = new GTextField(controls, 85, 212, 40, 20, G4P.SCROLLBARS_NONE);
  mDimX.setText("15");
  mDimX.setOpaque(true);
  mDimX.addEventHandler(this, "mDimX_change1");
  mDimY = new GTextField(controls, 130, 212, 40, 20, G4P.SCROLLBARS_NONE);
  mDimY.setText("15");
  mDimY.setOpaque(true);
  mDimY.addEventHandler(this, "mDimY_change1");
  mDimZ = new GTextField(controls, 175, 212, 40, 20, G4P.SCROLLBARS_NONE);
  mDimZ.setText("15");
  mDimZ.setOpaque(true);
  mDimZ.addEventHandler(this, "mDimZ_change1");
  controls.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow controls;
GSlider threshold_value; 
GLabel title1; 
GLabel setting1; 
GLabel setting3; 
GTextField scaleY; 
GTextField scaleZ; 
GLabel setting2; 
GCheckbox binaryNoise; 
GTextField scaleX; 
GLabel setting4; 
GTextField offsetX; 
GTextField offsetY; 
GTextField offsetZ; 
GLabel title2; 
GLabel setting5; 
GTextField mSizeX; 
GTextField mSizeY; 
GTextField mSizeZ; 
GLabel setting6; 
GTextField mDimX; 
GTextField mDimY; 
GTextField mDimZ; 
