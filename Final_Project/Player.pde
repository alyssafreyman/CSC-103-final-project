class Player {

  //variables
  int x;
  int y;
  int size;
  int c;
  int runSpeed = 7; 
  int jumpSpeed;
  int fallSpeed;
  int topBound; 
  int bottomBound;
  int leftBound;
  int rightBound;
  int jumpHeight;
  int peakY;
  int health;
  int playerLives = 1000;

  //booleans
  boolean movingLeft;
  boolean movingRight;
  boolean movingUp;
  boolean movingDown;
  boolean isDead;

  //constructor
  Player () {
    x = 100;
    size = 100;
    y = height-size;
    c = color (#8FF0E8);
    playerLives = 100;


    //speeds
    runSpeed = 5;

    //boundaries
    topBound = y; 
    bottomBound = y + size;
    leftBound = x;
    rightBound = x + size;
    jumpHeight = 10;
    peakY = 0; //how high it can go
  }

  //draws player

  void moveLeft() {
    if (movingLeft == true) {
      x -= runSpeed;
    }
  }

  void moveRight() {
    if (movingRight == true) {
      x += runSpeed;
    }
  }

  void moveUp() {
    if (movingUp == true) {
      y -= runSpeed;
    }
  }

  void moveDown() {
    if (movingDown == true) {
      y += runSpeed;
    }
  }

  void reset() {
    topBound = y; 
    bottomBound = y + size;
    leftBound = x;
    rightBound = x + size;
  }

  void wallDetect () { 
    if (x <= 0) {
      runSpeed = 0;
      x = 100;
      runSpeed = 7;
    }
    if (x+size >= width) {
      runSpeed = 0;
      x = width - 100;
      runSpeed = 7;
    }

    if (y <= size) {
      runSpeed = 0;
      y = size;
      runSpeed = 7;
    }

    if (y+size >= height) {
      runSpeed = 0;
      y = height - 100;
      runSpeed = 7;
    }
  }
}
