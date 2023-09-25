class AIShip {
  PImage img;
  PVector pos, vel, dest;
  float radius = 50;

  AIShip (PImage img) {
    this.img = img;
    this.pos = new PVector (width/2, -height/4);
    this.vel = new PVector (0, 0);
    this.dest = this.pos.copy ();
  }
  
  void move (boolean usingZoomAbility) {
    this.dest.x = (2 * width / 5) * sin (2 * 2 * PI * this.pos.y / height) + (width/2); 
    this.vel = PVector.sub (this.dest, this.pos);
    this.vel.setMag (min (this.vel.mag (), 1)); 
    this.pos.add (this.vel);
    if (usingZoomAbility) { this.pos.y += zoomSpeed; } 
  }

  void moveDown () {
    this.dest.y += height/4;
  }
  void moveUp () {
    this.dest.y -= height/4;
  }

  void reset () {
    this.dest.y = -height/4;
    this.pos.y = -height/4;
  }

  void render () {
    imageMode (CENTER);
    image (this.img, this.pos.x, this.pos.y);
  }  
}
