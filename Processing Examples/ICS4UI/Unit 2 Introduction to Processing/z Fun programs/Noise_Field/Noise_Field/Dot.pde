class Dot {
  // The higher this is, the faster the rainbow cycles
  static final float COLOR_MULT = 1500;
  // Represents 1 / mass
  static final float INV = 0.9;

  PVector pos;
  PVector vel;

public
  Dot(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }

public
  void update() {
    int x = floor(pos.x / CELL_SIZE);
    int y = floor(pos.y / CELL_SIZE);

    // a = F/m
    vel.add(field[x][y].mult(INV));

    vel.limit(4);
    pos.add(vel);
  }

  // Wrap dots around the edges of the window
public
  void wrap() {
    if (pos.x >= width) {
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width - 1;
    }
    if (pos.y >= height) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height - 1;
    }
  }

public
  void show() {
    if (rainbowMode) {
      fill(time * COLOR_MULT % 255, 255, 255);
    } else {
      fill(255, 0, 255, 40);
    }
    circle(pos.x, pos.y, 3);
  }
}
