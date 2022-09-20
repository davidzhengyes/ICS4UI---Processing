class Person
{
  int x;
  int y;
  int assignedX;
  int assignedY;
  int speed;
  int size;
  int wait;
  boolean luggage;

  Person(int xi, int yi, int assignedXi, int assignedYi, int speedi, int sizei) {
    this.x = xi;
    this.y = yi;
    this.assignedX = assignedXi;
    this.assignedY = assignedYi;
    this.speed = speedi;
    this.size = sizei;
    this.wait = WAITTIME;
    this.luggage = true;
  }

    void drawSelf() {
      noStroke();
      fill(255.0, 0.0, 0.0);
      ellipse((float)this.x, (float)this.y, (float)this.size, (float)this.size);
      
      if (this.luggage) {
        rect((float)this.x, (float)this.y, (float)this.size, (float)this.size);
      }

    }
    
    void drawSeat() {
      fill(0,0,0);
      stroke(255,0,0);
      rect((float)this.assignedX - this.size/2, (float)this.assignedY- this.size/2, (float)this.size, (float)this.size);
    }

    boolean checkFront(  Person[] people) {
    for (int i = 0; i < people.length; ++i) {
      float space = dist((float)this.x, (float)this.y, (float)people[i].x, (float)people[i].y);
      if (space < (this.size + people[i].size + 20) / 2 && this.x < people[i].x && people[i] != this) {
        return false;
      }
    }
    return true;
  }

    boolean move(Person[] people) {
    if (this.x < this.assignedX) {
      if (this.checkFront(people)) {
        this.x += this.speed;
        if (abs(this.x - this.assignedX) < this.speed) {
          this.x = this.assignedX;
        }
        return true;
      }
    } else if (this.wait > 0) {
      --this.wait;
      return true;
    } else if (this.y > this.assignedY && abs(this.y - this.assignedY) > this.speed) {
      this.luggage = false;
      this.y -= this.speed;
      return true;
    } else if (this.y < this.assignedY) {
      this.luggage = false;
      this.y += this.speed;
      return true;
    } else {
      this.y = this.assignedY;
    }
    return false;
  }
}
