class Ship {
  PImage img;
  PVector pos, vel, dest;
  float radius = 50;

  Ship () {
    this.img = loadImage ("ship.png");
    this.img.resize (200, 200);
    this.pos = new PVector (width/2, 3*height/4);
    this.vel = new PVector (0, 0);
    this.dest = this.pos;
  }
  
  void move () {
    this.vel = PVector.sub (this.dest, this.pos);
    this.vel.setMag (min (this.vel.mag (), 5)); 
    this.pos.add (this.vel);
  }

  void render () {
    imageMode (CENTER);
    image (this.img, this.pos.x, this.pos.y);
  }  
}