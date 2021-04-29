class Enemy {
  //declaring variables

  int x;
  int y;
  int dx;
  int dy;
  int w;
  int h;
  int c;
  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;
  int speed;
  int health;

  boolean isHit;
  boolean isDead;

  Animation enemyAnimation;

  //constructor
  Enemy(int tempX, int tempY, Animation tempEnemyAnimation) {
    x= tempX;
    y=tempY;
    enemyAnimation = tempEnemyAnimation;
   health = 3;
    w = 150;
    h = 100;
    c = color(#D860BF);
    dx = 5;
    dy = 5;
    speed = 3;

    //enemy boundaries
    topBound = y; 
    bottomBound = y + h;
    leftBound = x;
    rightBound = x + w;
  }

  void render () {
    fill (c);
    rect (x, y, w, h);
  }

  void move(Player bravestone) {
    if (bravestone.x <= x) {
      x -=speed;
    }
    if (bravestone.x >= x) {
      x +=speed;
    }
    // if player is below enemy
    if (bravestone.y >= y) {
      y +=speed;
    }
    // if player is above enemy
    if (bravestone.y <= y) {
      y -=speed;
    }
  }

  void reset () {
    topBound = y; 
    bottomBound = y + h;
    leftBound = x;
    rightBound = x + w;
  }

  void isHit(Bullet river) {
    if (river.rightBound >= leftBound) {
      if (river.leftBound <= rightBound) {
        if (river.topBound <= bottomBound) {
          if (river.bottomBound >=topBound) {
            owSound.play();
            river.isDestroyed = true;
            health = health -1;
            if (health <= 0) {
              isDead = true;
            }
          }
        }
      }
    }
  }  

  void hitsPlayer(Player bravestone) {
    if (bravestone.rightBound >= leftBound) {
      if (bravestone.leftBound <= rightBound) {
        if (bravestone.topBound <= bottomBound) {
          if (bravestone.bottomBound >=topBound) {
            if (bravestone.playerLives>=0) {
              bravestone.playerLives = bravestone.playerLives - 1;
            }
          }
        }
      }
    }
  }

  void wallDetect () { 
    if (x <= 0) {
      speed = 0;
      x = 100;
      speed = 3;
    }
    if (x+h >= width) {
      speed = 0;
      x = width - 100;
      speed = 3;
    }

    if (y <= h) {
      speed = 0;
      y = h;
      speed = 3;
    }

    if (y+h >= height) {
      speed = 0;
      y = height - 100;
      speed = 3;
    }
  }
}
