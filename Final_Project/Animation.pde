class Animation {
  //variables
  //holds all of the images for the animation
  PImage [] images;
  //tells you how fast to move through the animation
  float speed;
  //allows you to adjust how big the animation is on the screen
  float scale;

  //index should be equal to the number of images
  float index;
  //will do one full animation if true
  boolean isAnimating;


  //constructor
  Animation (PImage [] tempImages, float tempSpeed, float tempScale ) {

    images = tempImages;
    speed = tempSpeed;
    scale = tempScale;
    index = 0;
    isAnimating = false;
  }

  //updates the index which image to add
  void next() {
    //update the index 
    index += speed;

    //resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating = false;
    }
  }

  //display an image of the animation
  void display (int x,int y) {
    imageMode (CENTER);
    if (isAnimating) {
      int imageIndex = int (index);
      PImage img = images [imageIndex];
      image (img, x, y, img.width*scale, img.height*scale);

      //increment the index of the images to display
      next();
    } else {
      PImage img = images [0];
      image (img, x, y, img.width*scale, img.height*scale);
    }
  }
}
