class Label {

  float x, y, w, h;
  String text;
  color c;

  Label(float x_, float y_, float w_, float h_, String text_, color c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    c = c_;
  }

  void show() {
    stroke(0);
    fill(c);
    rect(x, y, w, h, 5);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, x + w/2, y + h/2);
  }
  
  
  boolean mouseOver() {
    boolean overX = (x<=mouseX && mouseX<=x+w);
    boolean overY = (y<=mouseY && mouseY<=y+h);
    return overX && overY;
  }
}
