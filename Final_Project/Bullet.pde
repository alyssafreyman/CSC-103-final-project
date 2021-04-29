class Bullet {

  //variables
  int x;
  int y;
  int d;
  int c;
  int speed; 
  int topBound; 
  int bottomBound;
  int leftBound;
  int rightBound;

  boolean isFiring;
boolean isDestroyed = false;

  //constructor
  Bullet() {
    x = player1.x+100;
    y = player1.y-20;
    c = color(#646464);
    d = 20;
    speed = 10;
    topBound = y;
    bottomBound = y + d;
    leftBound = x;
    rightBound = x + d;
  }

  //draws bullet
  void render () {
    fill (c);
    circle (x, y, d);
  }

  // this updates the position of the bullet
  void move() {
    x = x + speed;
  }

  void reset () {
    topBound = y - d;
    bottomBound = y + d;
    leftBound = x - d;
    rightBound = x + d;
  }
}
