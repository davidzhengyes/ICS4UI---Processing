class Tree
{
  PVector location = new PVector();
  PVector size = new PVector();
  PImage image;

  Tree (String i, PVector l, PVector s)
  {
    this.image = loadImage(i);
    this.location = l;
    this.size = s;
  }

  //drawing tree
  void drawTree()
  {
    this.image.resize(int(size.x), int(size.y));
    imageMode(CENTER);
    image(this.image, location.x, location.y);
  }

  //changing tree image
  void lightTree(String image)
  {
    this.image = loadImage(image);
  }
}
