import processing.sound.*;

SoundFile backgroundSound;
SoundFile pewSound;
SoundFile owSound;

//declares an arrayList of bullets
ArrayList<Bullet> bulletList;

//declares an arrayList of enemies
ArrayList<Enemy> enemy1List;
ArrayList<Enemy> enemy2List;
ArrayList<Enemy> bossList;

Enemy generic;
Player player1;

PImage[] bravestone_runningImages;
Animation bravestone_runningAnimation;

PImage[] VanPeltNewImages;
Animation VanPeltNewAnimation;

PImage[] VanPeltOldImages;
Animation VanPeltOldAnimation;

PImage title;
PImage level1;
PImage instructions;
PImage level2;
PImage bosslevel;
PImage win;
PImage lose;

int switchVal = 0;



PImage[] enemyImages;
Animation daveAnimation;

boolean isAnimating;

boolean isFirstRound = true;



color[] backgroundColorArray;

void setup() {
  //initialize the sound variable for background music
  backgroundSound = new SoundFile (this, "background.mp3");
  //initialize the sound variable for shooting sound effect
  pewSound = new SoundFile (this, "pew.mp3");
  //initialize the sound variable for jump sound effect
  owSound = new SoundFile (this, "ow.mp3");

  //settings
  size (1400, 800);

  //title page
  title = loadImage("title.png");
  title.resize (width, height);

  //instructions page
  instructions = loadImage("instructions.png");
  instructions.resize (width, height);

  //level 1 page
  level1 = loadImage("level_1.png");
  level1.resize (width, height);

  //level 2 page
  level2 = loadImage("level_2.png");
  level2.resize (width, height);

  //level 3 page
  bosslevel = loadImage("boss_level.png");
  bosslevel.resize (width, height);

  //win page
  win = loadImage("win_page.png");
  win.resize (width, height);

  //lose page
  lose = loadImage("lose_page.png");
  lose.resize (width, height);


  //array lists
  bulletList = new ArrayList<Bullet>();

  enemy1List = new ArrayList<Enemy>();
  enemy2List = new ArrayList<Enemy>();
  bossList = new ArrayList<Enemy>();

  //saying how many images are in the array for player
  bravestone_runningImages = new PImage[3]; 

  //saying how many images are in the array for enemy
  enemyImages = new PImage[3];
  VanPeltNewImages = new PImage[3];
  VanPeltOldImages = new PImage[3];
  player1 = new Player();




  //fill array of bravestone images
  for (int i = 0; i<bravestone_runningImages.length; i++) {
    bravestone_runningImages[i] = loadImage ("bravestone_running"+i+".png");
  }
  //initialize object
  bravestone_runningAnimation = new Animation(bravestone_runningImages, 0.2, 0.5);


  //fill array of Van Pelt (new) images
  for (int i = 0; i<enemyImages.length; i++) {
    VanPeltNewImages[i] = loadImage ("VanPeltNew_"+i+".png");
  }
  //initialize object
  VanPeltNewAnimation = new Animation(VanPeltNewImages, 0.2, 0.5);

  //fill array of Van Pelt (classic) images
  for (int i = 0; i<enemyImages.length; i++) {
    VanPeltOldImages[i] = loadImage ("VanPeltOld_"+i+".png");
  }
  //initialize object
  VanPeltOldAnimation = new Animation(VanPeltOldImages, 0.2, 0.5);

  //fill array of generic enemy images
  for (int i = 0; i<enemyImages.length; i++) {
    enemyImages[i] = loadImage ("enemy_"+i+".png");
  }
  //initialize object
  daveAnimation = new Animation(enemyImages, 0.2, 0.5);

  for (int i = 0; i< 3; i++) {
    Enemy dave = new Enemy((int)random(width/2, width), (int)random (0, height), daveAnimation);
    enemy1List.add(dave);
  }
  for (int i = 0; i< 5; i++) {
    Enemy dave = new Enemy((int)random(width/2, width), (int)random (0, height), daveAnimation);
    enemy2List.add(dave);
  }

  Enemy vanPeltClassic = new Enemy((int)random(width/2, width), (int)random (0, height), VanPeltOldAnimation);
  bossList.add(vanPeltClassic);


  Enemy vanPeltNew = new Enemy((int)random(width/2, width), (int)random (0, height), VanPeltNewAnimation);
  bossList.add(vanPeltNew);
}


void draw() {
  if (backgroundSound.isPlaying() == false) {
    backgroundSound.play();
  }


  //title page
  switch (switchVal) {
  case 0:
    background (title);
    break;

    //instructions
  case 1:
    background(instructions);
    break;

    //level 1
  case 2:
    isFirstRound = true;
    background(level1);

    if (player1.playerLives<=0) {
      switchVal=6;
    }

    //player lives tracker
    fill(255);
    textSize(35);
    text ("Player Lives", 100, 100);
    text (player1.playerLives, 325, 100);


    bravestone_runningAnimation.display (player1.x, player1.y);


    for (Enemy anEnemy : enemy1List) {
      anEnemy.reset();
      anEnemy.move(player1);
      anEnemy.wallDetect();
      anEnemy.hitsPlayer(player1);

      anEnemy.enemyAnimation.display (anEnemy.x, anEnemy.y);
      anEnemy.enemyAnimation.isAnimating = true;
    }
    //collision detection between enemy and bullet
    for (Enemy anEnemy : enemy1List) {
      for (Bullet bullet1 : bulletList) {
        anEnemy.isHit(bullet1);
      }
    }

    for (int i=enemy1List.size()-1; i>=0; i--) {
      if (enemy1List.get(i).isDead == true) {
        enemy1List.remove(i);

        if (enemy1List.size() == 0) {
          switchVal = switchVal +1;
        }
      }
    }

    break;

    //level 2
  case 3:
    background(level2);

    if (player1.playerLives<=0) {
      switchVal=6;
    }
    //player lives tracker
    fill(255);
    textSize(35);
    text ("Player Lives", 100, 100);
    text (player1.playerLives, 325, 100);

    bravestone_runningAnimation.display (player1.x, player1.y);
    for (Enemy anEnemy : enemy2List) {
      anEnemy.reset();
      anEnemy.move(player1);
      anEnemy.wallDetect();
      anEnemy.hitsPlayer(player1);

      anEnemy.enemyAnimation.display (anEnemy.x, anEnemy.y);
      anEnemy.enemyAnimation.isAnimating = true;
    }
    //collision detection between enemy and bullet
    for (Enemy anEnemy : enemy2List) {
      for (Bullet bullet1 : bulletList) {
        anEnemy.isHit(bullet1);
      }
    }

    for (int i=enemy2List.size()-1; i>=0; i--) {
      if (enemy2List.get(i).isDead == true) {
        enemy2List.remove(i);
      }
    }
    if (enemy2List.size() == 0) {
      switchVal = switchVal +1;

      for (Enemy anEnemy : bossList) {
        anEnemy.health = 10;
      }
    }
    break;

    //level 3 (boss)
  case 4:
    background(bosslevel);

    if (player1.playerLives<=0) {
      switchVal=6;
    }

    //player lives tracker
    fill(255);
    textSize(35);
    text ("Player Lives", 100, 100);
    text (player1.playerLives, 325, 100);


    bravestone_runningAnimation.display (player1.x, player1.y);
    for (Enemy anEnemy : bossList) {
      anEnemy.reset();
      anEnemy.move(player1);
      anEnemy.wallDetect();
      anEnemy.hitsPlayer(player1);

      anEnemy.enemyAnimation.display (anEnemy.x, anEnemy.y);
      anEnemy.enemyAnimation.isAnimating = true;
    }
    //collision detection between enemy and bullet
    for (Enemy anEnemy : bossList) {
      for (Bullet bullet1 : bulletList) {
        anEnemy.isHit(bullet1);
      }
    }

    for (int i=bossList.size()-1; i>=0; i--) {
      if (bossList.get(i).isDead == true) {
        bossList.remove(i);
        if (bossList.size() == 0) {
          switchVal = 5;
        }
      }
    }

    break;

    //win page
  case 5:
    background(win);
    break;

    //lose page
  case 6:
    background(lose);
    if (switchVal == 6) {
      player1.playerLives = 100;
      player1.x = 100;
    }
    enemy1List.clear();
    enemy2List.clear();
    bossList.clear();
    break;
  }


  //bullet functions
  for (Bullet bullet1 : bulletList) {
    bullet1.render();
    bullet1.move();
    bullet1.reset();
  }
  for (int i=bulletList.size()-1; i>=0; i--) {
    if (bulletList.get(i).isDestroyed == true) {
      bulletList.remove(i);
    }
  }
  //player functions
  player1.moveLeft();
  player1.moveRight();
  player1.moveUp();
  player1.moveDown();
  player1.reset();
  player1.wallDetect();
  //player1.healthDetect();
}

void keyPressed () {
  //moving player to the left
  if (keyCode == LEFT) {
    player1.movingLeft = true;
    bravestone_runningAnimation.isAnimating = true;
  }

  //moving player to the right
  if (keyCode == RIGHT) {
    player1.movingRight = true;
    bravestone_runningAnimation.isAnimating = true;
  }

  //moving player up
  if (keyCode == UP) {
    player1.movingUp = true;
  }
  //moving player down
  if (keyCode == DOWN) {
    player1.movingDown = true;
  }

  //firing a bullet
  if (keyCode == ' ') {
    bulletList.add (new Bullet());
    pewSound.play();
  }
  //to start game
  if (key == 's') {
    switchVal = 2;
  } 
  if (key == 'r') {
    switchVal = 2;

    isFirstRound = false;
    if (isFirstRound == false) {
      for (int i = 0; i< 3; i++) {
        Enemy dave = new Enemy((int)random(width/2, width), (int)random (0, height), daveAnimation);
        enemy1List.add(dave);
      }
      for (int i = 0; i< 5; i++) {
        Enemy dave = new Enemy((int)random(width/2, width), (int)random (0, height), daveAnimation);
        enemy2List.add(dave);
      }
      Enemy vanPeltClassic = new Enemy((int)random(width/2, width), (int)random (0, height), VanPeltOldAnimation);
      bossList.add(vanPeltClassic);

      Enemy vanPeltNew = new Enemy((int)random(width/2, width), (int)random (0, height), VanPeltNewAnimation);
      bossList.add(vanPeltNew);
    }
    isFirstRound=true;
  }

  //to get to instructions
  if (key == 'i') {
    switchVal = 1;
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    player1.movingLeft = false;
  }
  if (keyCode == RIGHT) { 
    player1.movingRight = false;
  }
  if (keyCode == UP) {
    player1.movingUp = false;
  }
  if (keyCode == DOWN) { 
    player1.movingDown = false;
  }
}
