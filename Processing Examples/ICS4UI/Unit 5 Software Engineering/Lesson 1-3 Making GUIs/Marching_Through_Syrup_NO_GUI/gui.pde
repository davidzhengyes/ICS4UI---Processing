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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:662070:
  appc.background(230);
} //_CODE_:window1:662070:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:890321:
  if( running ) {
    noLoop();
    running = false;
    pauseButton.setText("Resume");
    
  }
  
  else {
    loop();
    running = true;
    pauseButton.setText("Pause");
  }
} //_CODE_:pauseButton:890321:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 120, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(window1, 28, 22, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GButton pauseButton; 
