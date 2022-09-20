class Eye {
  float x; //x- and y- coordinates
  float y;
  float power; //in diopters, represents how much the lens can bend rays of light. negative power -> farsightedness, positive power -> nearsightedness
  float focalLength; //in metres, another representation of how strong the lense is (P=1/f)
  float nearPoint; //the closest an object can be where the eye can focus
  float farPoint; //the farthest an object can be where the eye can focus
  float recLensPower; //recommended lens power; the lensmaker equation 1/f=1/u-1/v returns the focal length and power of the lens that should be prescribed.
  //since the power is the adjustable parameter, this equation is used to calculate near/far points
  float lensedPower; //additive power of the eye and spectacle lens
  float lensedFL; //the same variables but using the lensed power
  float lensedNP;
  float lensedFP;
  Lens lens;

  Eye(float x, float y) { //aside from screen co-ordinates, all other parameters are set to the values an average eye has
    this.x = x;
    this.y = y;
    this.power = 0; //the power of an average eye is 60 diopters
    this.focalLength = 1/power; //P=1/f
    this.nearPoint = -0.25; //the near point for an average human eye is 25 cm
    this.farPoint = Float.NEGATIVE_INFINITY; //the normal eye should be able to see an infinite dist away
    this.recLensPower = 0; //an average eye doesn't require a prescription lens
  }

  void changePower(float p) {
    this.power = p;
    this.recLensPower = -p; //to have normal vision, the power should be 0, so recLensPower should be -p to balance out the power
    this.focalLength = 1/p;

    if (this.recLensPower > 0) {
      this.farPoint = Float.NEGATIVE_INFINITY; //if the recommended lens power is positive, the eye is farsighted so has the average far point of infinity
      this.nearPoint = -0.25/(this.recLensPower*-0.25+1); //using a modified version of the lensmaker equation with u=-0.25 (normal near point) and P=1/f to solve for v
      //see https://bit.ly/2WSuXwv for more details
    } else {
      this.nearPoint = -0.25; //if the recommended lens power is negative, the eye is nearsighted so has the average near point of 0.25 cm
      this.farPoint = 1/recLensPower; //again using a modified version of the lensmaker equation with u=-infinity (normal far point) and P
      //see https://bit.ly/2Y0wWeM for more details
    }
  }

  void changeLensedPower() { //same but using lensed power
    this.lensedPower = this.power + this.lens.power;

    float lensedRLP = -this.lensedPower;
    if (lensedRLP > 0) {
      this.lensedFP = Float.NEGATIVE_INFINITY;
      this.lensedNP = -0.25/(lensedRLP*-0.25+1);
    } else {
      this.lensedNP = -0.25;
      this.lensedFP = 1/lensedRLP;
    }
  }

  void addLens(Lens l) {
    this.lens = l;
    l.eye = this;

    this.lensedPower = this.power + this.lens.power;
    float lensedRLP = -this.lensedPower;
    if (lensedRLP > 0) {
      this.lensedFP = Float.NEGATIVE_INFINITY;
      this.lensedNP = (-0.25*(1/lensedRLP))/(-0.25-(1/this.lensedPower));
    } else {
      this.lensedNP = -0.25;
      this.lensedFP = 1/lensedRLP;
    }
  }

  void drawSelf() { //draws representation of eye and lens
    ellipseMode(CENTER);
    noFill();
    stroke(255);
    ellipse(this.x, this.y, 50, 50);

    stroke(0, 255, 255);
    ellipse(this.x-15, this.y, 15, 30);

    textSize(10);
    text("Eye", this.x, this.y-30);
  }

  void drawRays(float dist) { //draws representative rays from a point on the image through the lens and to the retina
    stroke(255, 255, 0);
    line(this.x-15-dist*2500, this.y-15, this.x-15, this.y-15);

    //the line that goes through the centre of a lens does not get refracted, so its slope does not change
    float m = 15/(dist*2500); //since the line is drawn at the height of the lens, delta y is 5, and since dist is between the x of the image and lens, delta y is dist
    float b = this.y-m*(this.x-15);
    
    //finds the intersection between the unrefracted ray and the retina (back of eye)
    float[] intersection = new float[2];
    float h = this.x;
    float k = this.y;
    intersection[0] = (-m*b+100*m+650+sqrt(-421875*pow(m,2)+130000*m-1300*m*b+200*b-pow(b,2)-9375))/(pow(m,2)+1); //isolated, expanded solution between y=mx+b and (x-h)^2+(y-k)^2=r^2
                                                                                                                  //with h as the eye's x, k as the eye's y, and 25 as the radius
    intersection[1] = m*intersection[0]+b;
    
    fill(255,255,0);
    line(this.x-15-dist*2500, this.y-15, intersection[0], intersection[1]);
    line(this.x-15, this.y-15, intersection[0], intersection[1]);
  }
}
