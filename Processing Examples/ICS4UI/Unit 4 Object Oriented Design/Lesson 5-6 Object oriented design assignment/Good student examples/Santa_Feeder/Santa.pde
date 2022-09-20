class Santa //<>// //<>//
{
  float speed;
  color col;
  int hunger;
  int thirst;
  int size;
  int targetIndex;
  PVector location = new PVector(width/2.0, height/2.0);

  Santa (float s, color c, int si, int h, int t)
  {
    this.speed = s;
    this.col = c;
    this.hunger = h;
    this.thirst = t;
    this.size = si;
  }

  // Spawning randomly within a range
  void spawn(int x1, int x2, int y1, int y2)
  {
    location.x = round(random(x1, x2));
    location.y = round(random(y1, y2));
  }

  // Drawing Santa
  void drawSanta()
  {
    fill(col);
    rect(location.x, location.y, size, size);
  }

  //
  // Moving santa in general
  //
  void move()
  {
    //Checking if there are snacks left
    boolean cookiesLeft = false;
    boolean milkLeft = false;

    for (int i =0; i < cAmount; i ++)
    {
      if (snacks[i].eaten == false)
      {
        cookiesLeft = true;
        break;
      }
    }
    for (int i = cAmount; i < cAmount + mAmount; i ++)
    {
      if (snacks[i].eaten == false)
      {
        milkLeft = true;
        break;
      }
    }


    if ((hunger <= 0 && thirst <= 0) || (hunger <= 0 && (thirst>0 && (milkLeft==false))) || (thirst <= 0 && (hunger>0 && (cookiesLeft==false))) || ((hunger > 0 && cookiesLeft ==false) && (thirst>0 && (milkLeft==false)))) // if he is full or there is none left of the snack he wants
    {
      this.moveToTree(christmasTree);
    } else
    {
      this.decideTarget(snacks);
      this.moveToSnack(snacks);
    }
  }

  //Deciding target snack
  void decideTarget(Snack[] s)
  {
    float smallestDistance = width + height; //all snacks have a smaller distance

    for (int i = 0; i < s.length; i ++)
    {
      if ( ( ( (hunger>0) && (s[i].type == "cookie") ) || ((thirst>0) && (s[i].type == "milk"))) && s[i].eaten == false) // if Santa is hungry and it is a cookie, or Santa is thirsty and it is milk and the thing exists
      {
        if (getDistance(s[i].location.x, s[i].location.y, this.location.x, this.location.y) < smallestDistance) // if it is closer
        {
          smallestDistance = getDistance(s[i].location.x, s[i].location.y, this.location.x, this.location.y); // go towards it
          targetIndex = i;
        }
      }
    }
  }


  //Moving Santa to Snack
  void moveToSnack(Snack[] s)
  {
    // Calculating x and y speed
    float xDist = s[targetIndex].location.x - location.x;
    float yDist = s[targetIndex].location.y - location.y;
    float totalDist = pow(pow(xDist, 2) + pow(yDist, 2), 0.5);

    float xMag = xDist / totalDist;
    float yMag = yDist / totalDist;


    if (totalDist >= speed) // if it is out of reach...
    {
      this.location.x += this.speed * xMag; //go towards it
      this.location.y += this.speed * yMag;
    } else //else...
    {
      this.location.x = s[targetIndex].location.x; //be there...
      this.location.y = s[targetIndex].location.y;
      this.eat(s[targetIndex]); //and eat it
    }
  }

  //Moving target to christmas tree
  void moveToTree(Tree t)
  {
    // Calculating x and y speed
    float xDist = t.location.x - location.x;
    float yDist = t.location.y - location.y;
    float totalDist = pow(pow(xDist, 2) + pow(yDist, 2), 0.5);

    float xMag = xDist / totalDist;
    float yMag = yDist / totalDist;

    if (totalDist >= speed) // if it is out of reach...
    {
      this.location.x += this.speed * xMag; //go towards it
      this.location.y += this.speed * yMag;
    } else //else...
    {
      this.location.x = t.location.x; //be there...
      this.location.y = t.location.y;
      t.lightTree("litTree.png");
    }
  }

  //Calculating distance between target and Santa
  float getDistance(float x1, float y1, float x2, float y2)
  {
    return sqrt( pow(x1 - x2, 2) + pow(y1 - y2, 2));
  }

  // Eating a snack
  void eat(Snack s)
  {
    s.eaten = true;

    if ( s.type == "cookie")
      this.hunger -= s.hunger;

    else
      this.thirst -= s.hunger;

    delay(round(eatingSpeed * 1000));
  }
}
