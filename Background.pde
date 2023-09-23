class Background {
  PImage slide1, slide2;
  float slide1_y, slide2_y;
  final float slide_height = 1000;
  final float vel = 0.5;

  Background () {
    this.slide1 = loadImage ("star_background.png");
    this.slide2 = loadImage ("star_background.png");
    this.slide1_y = 0;
    this.slide2_y = -slide_height;
  }
  
  void move (boolean usingZoomAbility) {
    this.slide1_y += usingZoomAbility ? zoomSpeed : vel;
    this.slide2_y += usingZoomAbility ? zoomSpeed : vel;
    if (this.slide1_y >= height) {
      this.slide1_y = this.slide2_y - slide_height; 
    }
    if (this.slide2_y >= height) {
      this.slide2_y = this.slide1_y - slide_height;
    }
  }

  void render () {
    pushMatrix ();
    imageMode (CORNER);
    image (this.slide1, 0, this.slide1_y);
    image (this.slide2, 0, this.slide2_y);
    popMatrix ();
  }  
}
