class Snack
{
  color col;
  float size;
  int hunger;
  String type;
  boolean eaten;
  PVector location = new PVector();


  Snack ( String t, color c, float s, int h)
  {
    this.col = c;
    this.size = s;
    this.type = t;
    this.hunger = h;
    this.eaten = true;
  }

  //spawning snacks
  void spawn(int rangeX1, int rangeX2, int rangeY1, int rangeY2)
  {
    this.location.x = round(random(rangeX1, rangeX2));
    this.location.y = round(random(rangeY1, rangeY2));
    this.eaten = false;
  }

  //draw snacks
  void drawSnack()
  {
    if (eaten == false)
    {
      fill(col);

      if (type == "cookie")
        circle(this.location.x + size/2, this.location.y + size/2, size);

      else
        rect(this.location.x, this.location.y, size/2, size);
    }
  }


  // deleting snacks after they are eaten
  void disappear()
  {
    this.eaten = true;
  }
}
