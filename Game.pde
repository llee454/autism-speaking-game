/*
  This class defines the Game state.
*/

final int zoomAbilityThreshold = 5;
final int timeAbilityThreshold = 10;

static class Game {
  static int level = 0;
  static int health = 5;
  static int score = 0;
  static PImage zoomAbilityIcon;
  static PImage timeAbilityIcon;
  static boolean hasZoomAbility = false;
  static boolean hasTimeAbility = false;
  static boolean usingZoomAbility = false;
  static boolean usingTimeAbility = false;
  static int zoomAbilityCounter = 0;
  static int timeAbilityCounter = 0;
}

// Draw the health meter.
void drawHealth () {
  pushMatrix ();
  for (int i = 0; i < Game.health; i ++) {
    fill ( color (200, 200, 255));
    rect (30, 30, 30, 30);
    translate (40, 0);
  }
  popMatrix ();
}

void drawScore () {
  pushMatrix ();
  textSize(64);
  fill (color (255, 255, 255));
  text ("Score " + nf (Game.score), width - 250, height - 30);
  popMatrix ();
}

void drawChapter () {
  pushMatrix ();
  textSize(64);
  fill (color (255, 255, 255));
  text ("Level " + nf (Game.level + 1), 30, height - 30);
  popMatrix ();
}

void drawAbilityIcons () {
  pushMatrix ();
    imageMode(CENTER);
    ellipseMode(CENTER);
    translate (50, 100);
    if (Game.hasZoomAbility) {
      if (Game.zoomAbilityCounter > 0) {
        fill (Game.usingZoomAbility ? color (255, 150, 150) : 255);
        circle (0, 0, 50);
      }

      image (Game.zoomAbilityIcon, 0, 0, 30, 30);
    }
    translate (80, 0);
    if (Game.hasTimeAbility) {
      if (Game.timeAbilityCounter > 0) {
        fill (Game.usingTimeAbility ? color (255, 150, 150) : 255);
        circle (0, 0, 50);
      }
      image (Game.timeAbilityIcon, 0, 0, 30, 30);
    }
  popMatrix ();
}
