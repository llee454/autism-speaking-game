class Star {
  PImage img;
  PVector pos, vel, dest;
  float radius = 50;

  Star () {
    this.img = loadImage ("star.png");
    this.img.resize (100, 100);
    this.pos = new PVector (width/2, 0);
    this.vel = new PVector (0, 5);
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
  
  void move () {
    this.pos.add (this.vel);
    
    if (this.pos.y > height + 100) {
      this.reset ();
    }
  }

  void render () {
    imageMode (CENTER);
    image (this.img, this.pos.x, this.pos.y);
  }
  
  boolean overlaps (PVector pos, float radius) {
    return PVector.dist (this.pos, pos) <= this.radius + radius;
  }
}
