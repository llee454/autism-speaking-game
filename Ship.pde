class Ship {
  PImage img;
  PVector pos, vel, dest;
  float radius = 500; // 50;

  Ship (PImage img) {
    this.img = img;
    this.pos = new PVector (width/2, 3*height/4);
    this.vel = new PVector (0, 0);
    this.dest = this.pos.copy ();
  }
  
  void move (boolean usingZoomAbility) {
    this.vel = PVector.sub (this.dest, this.pos);
    this.vel.setMag (min (this.vel.mag (), usingZoomAbility ? 50 : 5)); 
    this.pos.add (this.vel);
  }

  void render (boolean usingZoomAbility) {
    pushMatrix ();
    imageMode (CENTER);
    image (this.img, this.pos.x, this.pos.y);
    if (usingZoomAbility) {
      float scale = 1 - sq ((maxZoomAbilityCounter - zoomAbilityCounter) / maxZoomAbilityCounter);
      noStroke ();
      translate (this.pos.x, this.pos.y + 30);
      ellipseMode (CENTER);
      fill (255);
      beginShape ();
      vertex (0, -5);
      bezierVertex (
        -5 * scale, 0,
        -5 * scale, 5,
        -5 * scale, 0
      );
      bezierVertex (
        0, 200 * scale,
        0, 200 * scale,
        0, 200 * scale
      );
      bezierVertex (
        5 * scale, 5,
        5 * scale, -5,
        5 * scale, 0
      );
      bezierVertex (
        0, -5,
        0 * scale, -5,
        0, -5
      );
      endShape ();
      fill (204, 171, 204);
      circle (0, 0, 30 * scale);
      fill (234, 217, 209);
      circle (0, 0, 20 * scale);
    }
    popMatrix ();
  }  
}
