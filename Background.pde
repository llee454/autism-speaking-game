class Background {
  PImage slide1, slide2;
  float slide1_y, slide2_y;
  final float slide_height = 1000;
  final float vel = 0.5;

  Background () {
    this.slide1 = loadImage ("star_background.png");
    this.slide2 = loadImage ("star_background.png");
    this.slide1_y = 0;
    this.slide2_y = -1000;
  }
  
  void move () {
    this.slide1_y += vel;
    this.slide2_y += vel;
    if (this.slide1_y == height) {
      this.slide1_y = this.slide2_y - slide_height; 
    }
    if (this.slide2_y == height) {
      this.slide2_y = this.slide1_y - slide_height;
    }
  }

  void render () {
    imageMode (CORNER);
    image (this.slide1, 0, this.slide1_y, width, height);
    image (this.slide2, 0, this.slide2_y, width, height);
  }  
}
