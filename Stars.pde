class Star {
  PImage img;
  PVector pos;
  float radius = 50;

  Star () {
    this.img = loadImage ("star.png");
    this.pos = new PVector (width/2, 0);
  }
  
  void reset () {
      this.pos.y = -100;
      switch (int (random (3))) {
        case DEST_LEFT:
          this.pos.x = width/5;
          break;
        case DEST_CENTER:
          this.pos.x = width/2;
          break;
        case DEST_RIGHT:
          this.pos.x = 4*width/5;
      }
  }
  
  void move (boolean usingTimeAbility) {
    this.pos.y += usingTimeAbility ? 1 : 4;
  }

  void render () {
    pushMatrix ();
    imageMode (CENTER);    
    translate (this.pos.x, this.pos.y);
    rotate (2 * PI * 0.3 * this.pos.y / height);
    image (this.img, 0, 0);
    popMatrix ();
}
  
  boolean overlaps (PVector pos, float radius) {
    return PVector.dist (this.pos, pos) <= this.radius + radius;
  }
}
